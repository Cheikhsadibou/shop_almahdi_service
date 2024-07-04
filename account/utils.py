from django.core.mail import EmailMessage
# def send_confirmation_email(email, token_id, user_id):
#     print('Email onfirmation was send succeffuly !')

class Util:
    @staticmethod
    def send_confirmation_email(data):
    # def send_confirmation_email(email, token_id, user_id):
        email = EmailMessage(
            subject=data['email_subject'], body=data['email_body'],to=[data['to_email']])
        email.send()
