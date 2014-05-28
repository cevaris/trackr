require 'securerandom'
require 'net/ssh'

# t.string   "email",                  default: "", null: false
# t.string   "encrypted_password",     default: "", null: false
# t.string   "reset_password_token"
# t.datetime "reset_password_sent_at"
# t.datetime "remember_created_at"
# t.integer  "sign_in_count",          default: 0,  null: false
# t.datetime "current_sign_in_at"
# t.datetime "last_sign_in_at"
# t.string   "current_sign_in_ip"
# t.string   "last_sign_in_ip"
# t.string   "auth_token"
# t.string   "private_key",            default: ""
# t.string   "public_key",             default: ""
# t.string   "volume_id",              default: ""
# t.datetime "created_at"
# t.datetime "updated_at"


class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :default_values

  private

  def default_values

    self.auth_token ||= SecureRandom.uuid
    
    if self.private_key.blank? || self.public_key.blank?
      self.private_key, self.public_key = generate_ssh_keys()
    end
  end


  def generate_ssh_keys()
    key = OpenSSL::PKey::RSA.new 4096
    type = key.ssh_type
    data = [ key.to_blob ].pack('m0')

    openssh_format = "#{type} #{data}"
    return key.to_pem, openssh_format
  end

end
