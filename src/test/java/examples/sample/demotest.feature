Feature: KarateDemo
Scenario: ToDoInsert
  # Register（POST）
    * def getTime =
    """
    function(min) {
      var dateFormatType = Java.type('java.text.SimpleDateFormat');
      var dateFormat = new dateFormatType("yyyyMMddHHmmss");
      var date = new java.util.Date();
      date.setTime(date.getTime() + min*60*1000);

      return dateFormat.format(date).toString();
    }
    """
    * def timestamp = getTime(0)

    * def username = "user_" + timestamp
    * def email = "testmail_" + timestamp  + "@example.com"
    * def password = "test12345"

    * print username
    * print email
    * print password

    * def body =
      """
      {
       "username": #(username),
       "email": #(email),
       "password": #(password)
      }
      """
    Given url 'https://todolist-sample.com/register'
    * request body
    When method post
    Then status 201
    * print response
    * match response.message == "User registered successfully"


  # Login
    * def body =
      """
      {
      "identifier": #(email),
      "password": #(password)
      }
      """
    Given url 'https://todolist-sample.com/login'
    * request body
    When method post
    Then status 200
    * print response
    * match response.message == "User logged in successfully"


  # ToDoの登録（POST）
    * def body =
      """
      {
        "task": "報告書提出",
        "priority": 1,
        "due_date": "2024-10-26",
        "tags": "tag01"
      }
      """
    Given url 'https://todolist-sample.com/todos'
    * request body
    When method post
    Then status 201
    * print response
    * print response.task == "報告書提出"


  # Logout
    Given url 'https://todolist-sample.com/logout'
    * request body
    When method post
    Then status 200
    * print response
    * match response.message == "User logged out successfully"
    * match response.redirect == "/login"


  # ユーザー登録(".com"抜けの不正値)
  * def timestamp2 = getTime(0)

    * def username2 = "user_" + timestamp2
    * def email2 = "testmail_" + timestamp2  + "@example"
    * def password2 = "test12345"

    * print username2
    * print email2
    * print password2

    * def body =
      """
      {
       "username": #(username2),
       "email": #(email2),
       "password": #(password2)
      }
      """
    Given url 'https://todolist-sample.com/register'
    * request body
    When method post
    Then status 400
    * print response
    * match response.message == "Bad Request"

