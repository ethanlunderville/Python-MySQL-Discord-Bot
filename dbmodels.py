import database
import os


# In this file, students must implement database modeling techniques for all their entities.
class Datafetcher:

  @classmethod
  def query1(self):

    basesql = """SELECT brand as `shoe brand`, SUM(quantity) 
                    FROM Product 
                    GROUP BY brand 
                    HAVING sum(quantity) > 1;"""

    return self.executor(basesql)

  @classmethod
  def query2(self):

    basesql = """SELECT MAX(length), genre 
                    FROM Video 
                    GROUP BY genre 
                    HAVING MAX(length) > .10;"""

    return self.executor(basesql)

  @classmethod
  def query3(self):

    basesql = """SELECT SUM(total), date 
                    FROM Orders 
                    GROUP BY date 
                    HAVING SUM(total) > 55.00;"""

    return self.executor(basesql)

  @classmethod
  def query4(self):

    basesql = """SELECT count(Multimediacontent_idMultimediacontent), Multimediacontent_idMultimediacontent 
                    FROM Contentreport 
                    GROUP BY Multimediacontent_idMultimediacontent 
                    HAVING count(Multimediacontent_idMultimediacontent) > 2;"""

    return self.executor(basesql)

  @classmethod
  def query5(self):

    basesql = """SELECT firstname, lastname, itemsbought
                    FROM User 
                    WHERE idUser 
                    IN (SELECT User_idUser 
                        FROM Student 
                        JOIN Studentclass 
                        ON Student.idStudent = Studentclass.Student_idStudent 
                        WHERE Studentclass.Student_idStudent 
                        IN (SELECT Student_idStudent 
                            FROM Studentclass 
                            JOIN Class 
                            ON Studentclass.Class_idClass = Class.idClass 
                            WHERE Class.name = 'CSC675' ));"""

    return self.executor(basesql)

  @classmethod
  def query6(self, postId):

    basesql = """SELECT email 
                    FROM Account 
                    WHERE User_idUser IN (SELECT User_idUser 
                                        FROM Post 
                                        JOIN User on User_idUser = idUser 
                                        WHERE idPosts = %s);"""
    return self.executor_with_arg(basesql, postId)

  @classmethod
  def query7(self):

    basesql = """UPDATE Contentreport SET Admin_idAdmin = 1 WHERE idContentreport = 1;"""

    return self.executor(basesql)

  @classmethod
  def query7viewer(self):

    basesql = """SELECT * FROM Admin;"""

    return self.executor(basesql)

  @classmethod
  def query8(self):

    basesql = """INSERT INTO Orders VALUES (NULL, 1, 1, NOW(), 25.11);"""

    return self.executor(basesql)

  @classmethod
  def query8viewer(self):

    basesql = """SELECT * FROM User;"""

    return self.executor(basesql)

  @classmethod
  def query9(self):

    basesql = """CALL showposts;"""

    return self.executor(basesql)

  @classmethod
  def query10(self):

    basesql = """CALL deleteclasses()"""

    return self.executor(basesql)

  @classmethod
  def query10viewer(self):

    basesql = """SELECT * FROM Class"""

    return self.executor(basesql)

  @classmethod
  def query11(self, price):

    basesql = """SELECT priceDeterminer(%s);"""

    return self.executor_with_arg(basesql, price)

  @classmethod
  def query12(self, accountId):

    basesql = """SELECT timepassed(%s);"""

    return self.executor_with_arg(basesql, accountId)

  @classmethod
  def query12viewer(self):

    basesql = """SELECT * FROM Account;"""

    return self.executor(basesql)

  @classmethod
  def query15(self, userId):

    basesql = """DELETE FROM User WHERE idUser = %s;"""

    return self.executor_with_arg(basesql, userId)

  @classmethod
  def query15viewer(self):

    basesql = """select * from Account join User on User.idUser = Account.User_idUser;"""

    return self.executor(basesql)

  @classmethod
  def query16(self, postId):

    basesql = """DELETE FROM Post WHERE idPosts = %s;"""

    return self.executor_with_arg(basesql, postId)

  @classmethod
  def executor(self, basesql):

    connection = database.connect()
    result = ""
    with connection:
      with connection.cursor() as cursor:
        cursor.execute(basesql)
        result = cursor.fetchall()
      connection.commit()
    return result

  @classmethod
  def executor_with_arg(self, basesql, arg):

    connection = database.connect()
    result = ""
    with connection:
      with connection.cursor() as cursor:
        cursor.execute(basesql, arg)
        result = cursor.fetchall()
      connection.commit()
    return result
