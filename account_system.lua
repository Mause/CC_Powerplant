print("Are you sure you want to install the account system on this computer?")
print("Make sure this is a fresh computer first.")
answer = read()
if answer == "yes"
then

    shell.run("rom/programs/mkdir", "DB")
    shell.run("rom/programs/mkdir", "DB/DBlog")
    shell.run("rom/programs/mkdir", "DB/DBlvl")
    shell.run("rom/programs/mkdir", "DB/DBcur")


    -- create admin account


    file = io.open("DB/DBlog/admin", "w")
    file:write("admin")
    file:close()

    file = io.open("DB/DBlvl/admin", "w")
    file:write("3")
    file:close()


    -- install startup

    file = io.open("startup", "w")
    file:write('term.clear() \n shell.run("curempty") \n \n shell.run("startuptxt")\n answer = read() \n \n if answer == "create" \n then \n shell.run("create") \n end \n \n if answer == "login" \n then \n shell.run("login") \n if login == "good" \n then \n  shell.run("thingy") \n else \n  term.setCursorPos(5,8) \n  print("bad login") \n  term.setCursorPos(5,9) \n   sleep(0.5) \n   print("Shutting down") \n   sleep(1.5) \n   os.shutdown() \n  end \n end \n  \n if answer ~= "login" and answer ~= "create" \n then \n  term.setCursorPos(5,8) \n  print("You must either answer \'create\' or \'login\'.") \n  sleep(2) \n  term.setCursorPos(5,9) \n  print("Shutting down") \n  sleep(1) \n  os.shutdown() \n end \n ') 
    file:close()

    -- install curempty


    file = io.open("curempty", "w")
    file:write(' DBcn = io.open("DB/DBcur/name", "w") \n DBcn:close() \n DBcl = io.open("db/DBcur/level", "w") \n DBcl:close() \n ')
    file:close()

    -- install startuptxt


    file = io.open("startuptxt", "w")
    file:write('term.clear() \n term.setCursorPos(5,3) \n print("Do you want to \'login\' or \'create\' a new") \n term.setCursorPos(5,4) \n print("account? Type anything else to shutdown") \n term.setCursorPos(10,5) \n ')
    file:close()


    -- install create


    file = io.open("create", "w")
    file:write('term.clear() \n term.setCursorPos(18,3) \n print("Account Creation") \n  \n term.setCursorPos(10,8) \n write("Name:  ") \n term.setCursorPos(10,10) \n write("Password:  ") \n term.setCursorPos(20,8) \n name = read() \n term.setCursorPos(20,10) \n pass = read() \n  \n term.setCursorPos(5,12) \n  \n dbp = io.open("DB/DBlog/"..name, "r") \n if dbp \n then \n  dbp:close() \n print("Username already exists") \n  sleep(1) \n  term.setCursorPos(5,13) \n  print("Shutting down now") \n  sleep(1.5) \n  os.shutdown() \n else \n  dbp = io.open("DB/DBlog/"..name, "w") \n  dbp:write(pass) \n  dbp: close() \n   \n  dbl = io.open("DB/DBlvl/"..name, "w") \n  dbl:write("1") \n  dbl:close() \n  \n  print("New account created") \n  sleep(1) \n  term.setCursorPos(5,13) \n  print("ending session") \n  sleep(1.5) \n  os.shutdown() \n end \n ')
    file:close()


    --install login


    file = io.open("login", "w")
    file:write('term.clear() \n term.setCursorPos(20,3) \n print("Login System") \n term.setCursorPos(1,6) \n  \n term.setCursorPos(10,8) \n print("Name: ") \n term.setCursorPos(10,10) \n print("Password: ") \n term.setCursorPos(20,8) \n name = read() \n term.setCursorPos(20,10) \n pass = read() \n  \n login = ""  \n  \n  \n  \n dbp = io.open("DB/DBlog/" ..name) \n if dbp \n then \n  corpass = dbp:read() \n  dbp:close() \n  if pass == corpass \n  then \n   login = "good"  \n  end \n end \n  \n sleep(1) \n term.clear() \n term.setCursorPos(20,3) \n print("Login System") \n term.setCursorPos(1,6) \n if login == "good"  \n then \n  print("login accepted" ) \n end \n  \n if login == "good" \n then \n  DBcn = io.open("DB/DBcur/name", "w") \n  DBcn:write(name) \n  DBcn:close() \n   \n  DBl = io.open("DB/DBlvl/"..name, "r") \n  lvl = DBl:read() \n  DBl:close() \n  \n  DBcl = io.open("DB/DBcur/level", "w")  \n  DBcl:write(lvl)  \n  DBcl:close() \n end \n  \n sleep(1) \n  \n ')
    file:close()


    --install topui


    file = io.open("topui", "w")
    file:write('DBn = io.open("DB/DBcur/name", "r") \n curname = DBn:read() \n DBn:close() \n DBl = io.open("DB/DBcur/level", "r") \n curlvl = DBl:read() \n DBl:close() \n  \n term.setCursorPos(1,1) \n term.clearLine() \n write("Current user:  "..curname) \n term.setCursorPos(42,1) \n write("level: "..curlvl) \n term.setCursorPos(1,2) \n print("-------------------------------------------------") \n ')
    file:close()


    --install thingy


    file = io.open("thingy", "w")
    file:write('while true do \n term.clear() \n shell.run("topui") \n input = read() \n  \n if input == "help" \n then \n  shell.run("information") \n end \n  \n if input == "maintenance" and curname == "admin" \n then \n  break \n end \n  \n if input == "delete" \n then \n  shell.run("delete") \n end \n  \n if input == "set level" \n then \n  shell.run("setlvl") \n end \n  \n if input == "logout" \n then \n  shell.run("logout") \n end \n  \n end \n ')
    file:close()


    --install information


    file = io.open("information", "w")
    file:write('print("To view this text, type \'help\'") \n print("To quit, type \'logout\'. Be sure to do this when you\'re done.") \n print("To delete an account, type \'delete\'.") \n print("To set an account\'s level, type \'set level\'. You can only change the level of accounts with a lower level than yours and you can only choose a new level that is lower than your level.") \n print("To enter maintenance mode, type \'maintenance\' (only works for the admin account)") \n print() \n print("Press any key to continue") \n  \n while true do \n  event = os.pullEvent() \n  if event =="char" \n  then \n   break \n  end \n end \n ')
    file:close()

    --install logout


    file = io.open("logout", "w")
    file:write('print("Are you sure you want to log out?") \n sleep(1) \n answer = read() \n if answer == "yes" \n then \n  print("Ending session...") \n  sleep(2) \n  os.shutdown() \n else \n  print("Log out cancelled") \n  sleep(2) \n end \n  \n ')
    file:close()


    --install delete


    file = io.open("delete", "w")
    file:write('term.clear() \n reqlvl = 3 \n shell.run("topui") \n curlvl = curlvl +1 -1 \n if reqlvl > curlvl \n then \n  print("Your level is too low to delete accounts") \n else \n  \n term.setCursorPos(20,3) \n print("Account Deletion") \n term.setCursorPos(5,6) \n print("Which account do you want to delete?") \n term.setCursorPos(10,8) \n name = read() \n term.setCursorPos(5,10) \n  \n db = io.open("DB/DBlog/"..name,"r" ) \n if db \n then \n  db:close() \n  shell.run("rom/programs/rm", "DB/DBlog/"..name) \n  print("Account deleted") \n else  \n  print("Username doesn\'t exist.")  \n end \n  \n end \n  \n sleep(2) \n ')
    file:close()


    --install setlvl


    file = io.open("setlvl", "w")
    file:write('term.clear() \n shell.run("topui") \n term.setCursorPos(17,4) \n print("Set Clearance level") \n term.setCursorPos(5,6) \n print("Who\'s level do you want to change?") \n term.setCursorPos(10,8) \n name = read() \n term.setCursorPos(5,10) \n print("What do you want to set the level to?") \n term.setCursorPos(10,12) \n level = read() \n term.setCursorPos(5,14) \n sleep(1) \n DBl = io.open("DB/DBlvl/"..name, "r") \n if DBl \n then \n  tarlvl = DBl:read() \n  DBl:close() \n  if curlvl > tarlvl \n  then \n   if curlvl > level \n   then \n    DBl = io.open("DB/DBlvl/"..name, "w") \n    DBl:write(level) \n DBl:close() \n  print(name.."\'s level changed to "..level) \n   else \n    print("The desired level must be lower than your own") \n   end \n  else \n   print("Target\'s level is too high to be changed") \n  end \n else \n  print("Name not found") \n end \n  \n sleep(2.5) \n  \n ')
    file:close()


end