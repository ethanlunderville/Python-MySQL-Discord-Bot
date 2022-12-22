# imports
import os
import re
import discord
import master
import time
from master import Master

# environment variables
token = os.environ['DISCORD_TOKEN']
server = os.environ['DISCORD_GUILD']

#server_id = os.environ['SERVER_ID']  # optional
#channel_id = os.environ['CHANNEL_ID']  # optional

data = Master()
intents = discord.Intents.default()
intents.message_content = True
client = discord.Client(intents=discord.Intents.default())


@client.event
async def on_ready():
  """
    This method triggers with the bot connects to the server
    Note that the sample implementation here only prints the
    welcome message on the IDE console, not on Discord
    :return: VOID
    """
  print("{} has joined the server".format(client.user.name))


@client.event
async def on_message(message):
  """
    This method triggers when a user sends a message in any of your Discord server channels
    :param message: the message from the user. Note that this message is passed automatically by the Discord API
    :return: VOID
    """
  response = None  # will save the response from the bot
  if message.author == client.user:
    return  # the message was sent by the bot
  if message.type is discord.MessageType.new_member:
    response = "Welcome {}".format(
      message.author)  # a new member joined the server. Welcome him.
  else:
    # A message was send by the user.
    msg = message.content.lower()
    msg_data = msg.split(" ")
    command = msg_data[0]

    if command == "/show-brand-quantity":
      print("/show-brand-quantity")
      rstring = ""
      for x in data.get_brands():
        rstring += f"Brand: {x.name} , Price: {x.amount}\n"
      response = rstring

    elif command == "/longest-videos":
      print("/longest-videos")
      rstring = ""
      for x in data.get_videos():
        rstring += f"Genre: {x.genre} , Length: {x.length}\n"
      response = rstring

    elif command == "/order-sum-by-date":
      print("/order-sum-by-date")
      rstring = ""
      for x in data.get_dates():
        rstring += f"Total: {x.total} , Date: {x.date}\n"
      response = rstring

    elif command == "/number-of-reports":
      print("/number-of-reports")
      rstring = ""
      for x in data.get_content_items():
        rstring += f"Content ID: {x.id}, Number of reports: {x.reports_num}\n"
      response = rstring

    elif command == "/show-students-csc675":
      print("/show-names-of-students-CSC675")
      rstring = ""
      for x in data.get_users_names():
        rstring += f"Name: {x.firstname} {x.lastname}, Number of items purchased: {x.items_bought}\n"
      response = rstring

    elif command == "/show-email-on-post":
      print("/show-email-on-post")
      if msg_data.__len__() > 1:
        arg = msg_data[1]
        email = data.get_email(arg)
        if email.__len__() != 0:
          response = f"Email: {email[0].get('email')}"
        else:
          response = "No email was found"
      else:
        response = "There was a problem please try again with a post ID as an argument"

    elif command == "/update-content-report":
      print("/update-content-report")

      data.update_content_report()
      data.load_admins()
      response = "A content report was reviewed by an Admin and as such the Admin with id: 1 has had its reports reviewed number iterated. Use the /show-admins command before and after this command to see its effects"

    elif command == "/show-admins":
      print("/show-admins")
      rstring = ""
      for x in data.get_admins():
        rstring += f"Admin ID: {x.id}, Name: {x.firstname} {x.lastname}, Reports reviewed: {x.reviewed_num}\n"
      response = rstring

    elif command == "/insert-into-orders":
      print("/insert-into-orders")
      data.insert_into_orders()
      data.load_users()
      response = "An order was made by a user named ethan lunderville and because of this the users Items Purchased number was iterated. Please run /show-users before and after this command to see its effects "

    elif command == "/show-users":
      print("/show-users")
      rstring = ""
      for x in data.get_users():
        rstring += f"Name: {x.firstname} {x.lastname}, Items Purchased: {x.items_bought}\n"
      response = rstring

    elif command == "/show-posts-and-comments":
      print("/show-posts-and-comments")
      rstring = ""
      for x in data.get_posts_comments():
        rstring += f"Post ID: {x.id}, Post: {x.content}, Time: {x.time},\n"
        for z in x.comments:
          rstring += f"Comment ID: {z.id} Comment: {z.comment}\n"
      response = rstring

    elif command == "/delete-classes":
      print("/delete-classes")
      data.delete_classes()
      data.load_classes()
      if data.get_classes().__len__() == 0:
        print("Success")
        response = "Classes were deleted"
      else:
        print("failure")
        response = "There was a problem please try again"

    elif command == "/show-classes":
      print("/show-classes")
      rstring = ""
      for x in data.get_classes():
        rstring += f"id: {x.id} , name: {x.name}, subject {x.subject}\n"
      if rstring.__len__() > 1:
        response = rstring
      else:
        response = "There are no classes in this database, please run the reset-db command to reset classes"

    elif command == "/price-determiner":
      print("/pricedeterminer")
      try:
        if msg_data.__len__() > 1:

          arg = int(float(msg_data[1]))
          price_status = data.price_determiner(arg)
          response = price_status[0].get(f"priceDeterminer({arg})")
        else:
          response = "There was a problem please try again with at least two arguments"
      except Exception as e:
        response = "Please ensure that you provided a number as an argument"
        print(e)

    elif command == "/days-passed":
      print("/days-passed")
      if msg_data.__len__() > 1:
        arg = msg_data[1]
        var = data.days_passed(arg)
        days = var[0].get(f"timepassed('{arg}')")
        days = re.findall(r'\d+', str(days))[0]
        response = days
      else:
        response = "There was a problem please try again with a account ID as an argument"

    elif command == "/delete-user":
      print("/delete-user")
      if msg_data.__len__() > 1:
        arg = msg_data[1]
        data.delete_user(arg)
        data.load_users_accounts()
        response = "Data has been deleted. Use the /show-users-accounts command before and after running this command to see the effects."
      else:
        response = "There was a problem please try again with at least two arguments"

    elif command == "/show-users-accounts":
      print("/show-users-accounts")
      rstring = ""
      users_accounts = data.get_users_accounts()
      for x in users_accounts:
        rstring += f"Name: {x.firstname} {x.lastname}, Items Purchased: {x.items_bought}\n"
        if x.account is not None:
          rstring += f"Account ID: {x.account.idAccount}, Email {x.account.email}, Date Created: {x.account.date}\n"
      response = rstring

    elif command == "/delete-post":
      print("/delete-post")
      if msg_data.__len__() > 1:
        arg = msg_data[1]
        data.delete_posts_comments(arg)
        data.load_posts_comments()
        response = "Data has been deleted. Use the /show-posts-and-comments command to see the effects"
      else:
        response = "There was a problem please try again with at least two arguments"

    elif command == "/reset-db":
      # triggers a script to run on the host machine that resets DB
      os.system("curl -X POST <[IP OF DATABASE]> ?pnum=1122332214")
      print("PLEASE WAIT --- DATABASE LOADING")
      time.sleep(5)
      data.loadall()
      print("LOAD COMPLETE")
      response = "Database has been reset"

    elif command == "/refresh-data":
      data.loadall()
      response = "Data was refreshed"

  if response:
    # bot sends response to the Discord API and the response is show
    # on the channel from your Discord server that triggered this method.
    embed = discord.Embed(description=response)
    await message.channel.send(embed=embed)


try:
  # start the bot and keep the above methods listening for new events
  client.run(token)
except Exception as a:
  print(
    "Bot is offline because your secret environment variables are not set. Head to the left panel, "
    +
    "find the lock icon, and set your environment variables. For more details, read the README file in your "
    + "milestone 3 repository")
  print(a)
