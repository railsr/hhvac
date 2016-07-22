mailer вакансии с hh
добавить в crontab

```
AREA = 2 # 1-mosc, 2-spb, ... https://api.hh.ru/areas
TEXT = 'Ruby on rails'

# sender email/password
SMTP_USER = 'user@example.com'
SMTP_PASSWORD = 'your_password'

# receiver email
TO = 'user@example.com'
```


```
every 1.day, :at => '4:30 am' do
  command "ruby /scripts/jobs.rb"
end
```
