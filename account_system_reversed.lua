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

    file = "startup"
        term.clear()
        shell.run("curempty")

        shell.run("startuptxt")
        answer = read()

        if answer == "create"
            then
            shell.run("create")
        end

        if answer == "login"
            then
            shell.run("login")
            if login == "good"
                then
                shell.run("thingy")
            else
                term.setCursorPos(5,8)
                print("bad login")
                term.setCursorPos(5,9)
                sleep(0.5)
                print("Shutting down")
                sleep(1.5)
                os.shutdown()
            end
        end

        if answer ~= "login" and answer ~= "create"
            then
            term.setCursorPos(5,8)
            print("You must either answer \'create\' or \'login\'.")
            sleep(2)
            term.setCursorPos(5,9)
            print("Shutting down")
            sleep(1)
            os.shutdown()
        end 
    

    -- install curempty


    file = "curempty"
        DBcn = io.open("DB/DBcur/name", "w")
        DBcn:close()
        DBcl = io.open("db/DBcur/level", "w")
        DBcl:close()

    -- install startuptxt


    file = "startuptxt"
        term.clear()
        term.setCursorPos(5,3)
        print("Do you want to \'login\' or \'create\' a new")
        term.setCursorPos(5,4)
        print("account? Type anything else to shutdown")
        term.setCursorPos(10,5)


    -- install create


    file = "create"
        term.clear()
        term.setCursorPos(18,3)
        print("Account Creation")

        term.setCursorPos(10,8)
        write("Name:  ")
        term.setCursorPos(10,10)
        write("Password:  ")
        term.setCursorPos(20,8)
        name = read()
        term.setCursorPos(20,10)
        pass = read()

        term.setCursorPos(5,12)

        dbp = io.open("DB/DBlog/"..name, "r")
        if dbp
            then
            dbp:close()
            print("Username already exists")
            sleep(1)
            term.setCursorPos(5,13)
            print("Shutting down now")
            sleep(1.5)
            os.shutdown()
        else
            dbp = io.open("DB/DBlog/"..name, "w")
            dbp:write(pass)
            dbp: close()

            dbl = io.open("DB/DBlvl/"..name, "w")
            dbl:write("1")
            dbl:close()

            print("New account created")
            sleep(1)
            term.setCursorPos(5,13)
            print("ending session")
            sleep(1.5)
            os.shutdown()
        end


    --install login


    file = "login"
        term.clear()
        term.setCursorPos(20,3)
        print("Login System")
        term.setCursorPos(1,6)

        term.setCursorPos(10,8)
        print("Name: ")
        term.setCursorPos(10,10)
        print("Password: ")
        term.setCursorPos(20,8)
        name = read()
        term.setCursorPos(20,10)
        pass = read()

        login = ""



        dbp = io.open("DB/DBlog/" ..name)
        if dbp
            then
            corpass = dbp:read()
            dbp:close()
            if pass == corpass
                then
                login = "good"
            end
        end

        sleep(1)
        term.clear()
        term.setCursorPos(20,3)
        print("Login System")
        term.setCursorPos(1,6)
        if login == "good"
            then
            print("login accepted" )
        end

        if login == "good"
            then
            DBcn = io.open("DB/DBcur/name", "w")
            DBcn:write(name)
            DBcn:close()

            DBl = io.open("DB/DBlvl/"..name, "r")
            lvl = DBl:read()
            DBl:close()

            DBcl = io.open("DB/DBcur/level", "w")
            DBcl:write(lvl)
            DBcl:close()
        end

        sleep(1)


    --install topui


    file = "topui"
        DBn = io.open("DB/DBcur/name", "r")
        curname = DBn:read()
        DBn:close()
        DBl = io.open("DB/DBcur/level", "r")
        curlvl = DBl:read()
        DBl:close()

        term.setCursorPos(1,1)
        term.clearLine()
        write("Current user:  "..curname)
        term.setCursorPos(42,1)
        write("level: "..curlvl)
        term.setCursorPos(1,2)
        print("-------------------------------------------------")



    --install thingy


    file = "thingy"
        while true do
            term.clear()
            shell.run("topui")
            input = read()

            if input == "help"
                then
                shell.run("information")
            end

            if input == "maintenance" and curname == "admin"
                then
                break
            end

            if input == "delete"
                then
                shell.run("delete")
            end

            if input == "set level"
                then
                shell.run("setlvl")
            end

            if input == "logout"
                then
                shell.run("logout")
            end
        end


    --install information


    file = "information"
        print("To view this text, type \'help\'")
        print("To quit, type \'logout\'. Be sure to do this when you\'re done.")
        print("To delete an account, type \'delete\'.")
        print("To set an account\'s level, type \'set level\'. You can only change the level of accounts with a lower level than yours and you can only choose a new level that is lower than your level.")
        print("To enter maintenance mode, type \'maintenance\' (only works for the admin account)")
        print()
        print("Press any key to continue")

        while true do
            event = os.pullEvent()
            if event == "char"
                then
                break
            end
        end

    --install logout


    file = "logout"
        print("Are you sure you want to log out?")
        sleep(1)
        answer = read()
        if answer == "yes"
            then
            print("Ending session...")
            sleep(2)
            os.shutdown()
        else
            print("Log out cancelled")
            sleep(2)
        end


    --install delete


    file = "delete"
        term.clear()
        reqlvl = 3
        shell.run("topui")
        curlvl = curlvl +1 -1
        if reqlvl > curlvl
            then
            print("Your level is too low to delete accounts")
        else
            term.setCursorPos(20,3)
            print("Account Deletion")
            term.setCursorPos(5,6)
            print("Which account do you want to delete?")
            term.setCursorPos(10,8)
            name = read()
            term.setCursorPos(5,10)

            db = io.open("DB/DBlog/"..name,"r" )
            if db
                then
                db:close()
                shell.run("rom/programs/rm", "DB/DBlog/"..name)
                print("Account deleted")
            else
                print("Username doesn\'t exist.")
            end
        end
        sleep(2)


    --install setlvl


    file = "setlvl"
        term.clear()
        shell.run("topui")
        term.setCursorPos(17,4)
        print("Set Clearance level")
        term.setCursorPos(5,6)
        print("Who\'s level do you want to change?")
        term.setCursorPos(10,8)
        name = read()
        term.setCursorPos(5,10)
        print("What do you want to set the level to?")
        term.setCursorPos(10,12)
        level = read()
        term.setCursorPos(5,14)
        sleep(1)
        DBl = io.open("DB/DBlvl/"..name, "r")
        if DBl
            then
            tarlvl = DBl:read()
            DBl:close()
            if curlvl > tarlvl
                then
                if curlvl > level
                    then
                    DBl = io.open("DB/DBlvl/"..name, "w")
                    DBl:write(level)
                    DBl:close()
                    print(name.."\'s level changed to "..level)
                else
                    print("The desired level must be lower than your own")
                end
            else
                print("Target\'s level is too high to be changed")
            end
        else
            print("Name not found")
        end
        sleep(2.5)