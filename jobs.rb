require 'rubygems'
require 'httparty'
require 'mail'

AREA = 2 # 1-mosc, 2-spb, ... https://api.hh.ru/areas
TEXT = 'Ruby on rails'

# sender email/password
SMTP_USER = 'user@example.com'
SMTP_PASSWORD = 'your_password'

# receiver email
TO = 'user@example.com'

Mail.defaults do
  delivery_method :smtp, {
    address: 'smtp.mail.yahoo.com', # smtp.gmail.com
    port: 587,
    user_name: SMTP_USER,
    password: SMTP_PASSWORD,
    authentication: :plain,
    enable_starttls_auto: true
  }
end

def check_jobs
  url = "https://api.hh.ru/vacancies/?text=#{TEXT}+&area=#{AREA}+&items_on_page=100"
  response = HTTParty.get(url)
  body = JSON.parse(response.body)
  jobs = body['items']
  send_email(jobs)
end

def email_body(jobs)
  body = ""
  jobs.each do |job|
    body += "
    <h3>
      <a style='color:#9575CD' href=#{job['alternate_url']}>
        #{job['name']}
      </a>
    </h3>
    <p>
      #{job['snippet']['requirement']}<br/>
      #{job['snippet']['responsibility']}
    </p>
    <h4>
      #{job['area']['name']} /
      <a style='color:#BDBDBD' href=#{job['employer']['alternate_url']}>
        #{job['employer']['name']}
      </a>
    </h4>
    <br/>"
  end
  body
end

def send_email(jobs)
  mail = Mail.new do
    from    SMTP_USER
    to      TO
    subject "#{DateTime.now.strftime('%d.%m')} - Вакансии"

    html_part do
      content_type 'text/html; charset=UTF-8'
      body email_body(jobs)
    end
  end
  mail.deliver!
end

check_jobs
