import class_models
from class_models import *
import dbmodels
from dbmodels import Datafetcher


class Master:

  def __init__(self):
    self.loadall()

  ### THESE FUNCTIONS LOAD DATA INTO PROGRAM MEMORY

  def load_brands(self):
    self.brands = []
    brands = Datafetcher.query1()
    for x in brands:
      brand_object = Brand(x)
      self.brands.append(brand_object)

  def load_videos(self):
    self.videos = []
    videos = Datafetcher.query2()
    for x in videos:
      video_object = Video(x)
      self.videos.append(video_object)

  def load_dates(self):
    self.dates = []
    dates = Datafetcher.query3()
    for x in dates:
      date_object = Date(x)
      self.dates.append(date_object)

  def load_content_items(self):
    self.content_items = []
    content_items = Datafetcher.query4()
    for x in content_items:
      content_item_object = Content(x)
      self.content_items.append(content_item_object)

  def load_users_names(self):
    self.users_names = []
    users = Datafetcher.query5()
    for x in users:
      user_object = User(x)
      self.users_names.append(user_object)

  def load_admins(self):
    self.admins = []
    admins = Datafetcher.query7viewer()
    for x in admins:
      admin_object = Admin(x)
      self.admins.append(admin_object)

  def load_users(self):
    self.users = []
    users = Datafetcher.query8viewer()
    for x in users:
      user_object = User(x)
      self.users.append(user_object)

  def load_posts_comments(self):
    self.posts_comments = []
    Post.posts = {}
    posts = Datafetcher.query9()
    for x in posts:
      post_object = Post.check_init(x)
      if post_object not in self.posts_comments:
        self.posts_comments.append(post_object)

  def load_classes(self):
    self.classes = []
    classes = Datafetcher.query10viewer()
    for x in classes:
      class_object = Class(x)
      self.classes.append(class_object)

  def load_accounts(self):
    self.accounts = []
    accounts = Datafetcher.query12viewer()
    for x in accounts:
      account_object = Account(x)
      self.accounts.append(account_object)

  def load_users_accounts(self):
    self.users_accounts = []
    users = Datafetcher.query15viewer()
    for x in users:
      user_object = User(x)
      self.users_accounts.append(user_object)

  ### GETTERS START HERE

  # /show-brand-quantity
  def get_brands(self):
    return self.brands

  # /longest-videos
  def get_videos(self):
    return self.videos

  # /order-sum-by-date
  def get_dates(self):
    return self.dates

  # /number-of-reports
  def get_content_items(self):
    return self.content_items

  # /show-names-of-students-CSC675
  def get_users_names(self):
    return self.users_names

  #/show-email-on-post <postId>
  def get_email(self, postId):
    return Datafetcher.query6(postId)

  # view /update-content-report
  def get_admins(self):
    return self.admins

  # /update-content-report
  def update_content_report(self):
    Datafetcher.query7()

  # view /insert-into-orders
  def get_users(self):
    return self.users

  # /insert-into-orders
  def insert_into_orders(self):
    Datafetcher.query8()

  # /show-posts-and-comments
  def get_comments(self):
    return self.comments

  # /delete-classes
  def delete_classes(self):
    Datafetcher.query10()

  # show /delete-classes
  def get_classes(self):
    return self.classes

  # /pricedeterminer <price>
  def price_determiner(self, price):
    return Datafetcher.query11(price)

  # /days-passed <post>
  def days_passed(self, accountId):
    return Datafetcher.query12(accountId)

  # /delete-user
  def delete_user(self, userId):
    Datafetcher.query15(userId)

  #SHOW /delete user
  #SHOW users accounts
  def get_users_accounts(self):
    return self.users_accounts

  # delete-post
  def delete_posts_comments(self, postId):
    Datafetcher.query16(postId)

  #SHOW /delete post
  def get_posts_comments(self):
    return self.posts_comments

  ### CALLED IN CONSTRUCTOR

  def loadall(self):
    self.load_brands()
    self.load_videos()
    self.load_dates()
    self.load_content_items()
    self.load_users_names()
    self.load_admins()
    self.load_users()
    self.load_posts_comments()
    self.load_classes()
    self.load_accounts()
    self.load_users_accounts()
