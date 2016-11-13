import stream
import csv

client = stream.connect('vcmvt8tv73tv', '44shewyyamanngv7gdkxp7vt3f6vv6euwzmh9f2hrt9tvadxmgeuadfx57y86pj5',
                        location='us-east')
HomeSafe = client.feed('user', 'HomeSafe')


userinput = input('Enter message: ')


def add_to_feed(userinput):
    message = userinput
    activity_data = {'actor': 'HomeSafe',
                     'verb': 'add',
                     'message': message}

    HomeSafe.add_activity(activity_data)


def make_new_user(name):
    name = client.feed('timeline', 'HomeSafe')
    name.follow('user', 'HomeSafe')
