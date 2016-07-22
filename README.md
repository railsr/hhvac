mailer вакансии с hh

добавить в cronjobs с [whenever](https://github.com/javan/whenever)

```
every 1.day, :at => '4:30 am' do
  command "ruby /scripts/jobs.rb"
end
```

### перед использованием обновить следующие поля:

```
AREA = 2 # 1-mosc, 2-spb, ... https://api.hh.ru/areas
TEXT = 'Ruby on rails'

# sender email/password
SMTP_USER = 'user@example.com'
SMTP_PASSWORD = 'your_password'

# receiver email
TO = 'user@example.com'
```
