class CLIHelper
  def self.safe_session(session)
  	File.open("cli/clitemp.json","w") do |f|
  		f.truncate(0)
		  f.write(JSON.pretty_generate(session))
		end
  end

  def self.get_session
  	file = File.read('cli/clitemp.json')
		session = JSON.parse(file)
		session['current_account'] = SecureMessage.decrypt(session['current_account'])
		session
	rescue Errno::ENOENT => ex
  	nil
  end

  def self.authenticated?
  	session = self.get_session
  	if session
  		true
  	else
  		false
  	end
  end
end


