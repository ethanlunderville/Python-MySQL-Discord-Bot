class Brand:

  def __init__(self, dict):
    self.name = dict.get('shoe brand')
    self.amount = dict.get('SUM(quantity)')


class Video:

  def __init__(self, dict):
    self.genre = dict.get('genre')
    self.length = dict.get('MAX(length)')


class Date:

  def __init__(self, dict):
    self.total = dict.get('SUM(total)')
    self.date = dict.get('date')


class Content:

  def __init__(self, dict):
    self.reports_num = dict.get('count(Multimediacontent_idMultimediacontent)')
    self.id = dict.get('Multimediacontent_idMultimediacontent')


class User:

  def __init__(self, dict):
    self.firstname = dict.get('firstname')
    self.lastname = dict.get('lastname')
    self.items_bought = dict.get('itemsbought')
    if 'idAccount' in dict:
      self.account = Account(dict)


class Account:

  def __init__(self, dict):
    self.idAccount = dict.get('idAccount')
    self.email = dict.get('email')
    self.password = dict.get('password')
    self.date = self.email = dict.get('date')


class Admin:

  def __init__(self, dict):
    self.id = dict.get('idAdmin')
    self.firstname = dict.get('firstname')
    self.lastname = dict.get('lastname')
    self.reviewed_num = dict.get('reports_reviewed')


class Post:
  # Carries pointers to each post so as to not make duplicate copies when initializing comments
  posts = {}

  def __init__(self, dict):

    self.id = dict.get('idPosts')
    self.content = dict.get('content')
    self.time = dict.get('time')
    self.comments = []
    self.comments.append(Comment(dict))
    Post.posts[self.id] = self

  @classmethod
  def check_init(self, dict):

    if dict.get('idPosts') in Post.posts:
      Post.posts.get(dict.get('idPosts')).comments.append(Comment(dict))
      return Post.posts.get(dict.get('idPosts'))

    return Post(dict)


class Comment:

  def __init__(self, dict):
    self.id = dict.get('idComments')
    self.comment = dict.get('comment')


class Class:

  def __init__(self, dict):
    self.id = dict.get('idClass')
    self.name = dict.get('name')
    self.subject = dict.get('subject')
