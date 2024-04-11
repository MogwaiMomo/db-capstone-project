import pandas as pd

def root_connect(connector):
    try:
        connection = connector.connect(user="root", password="yoinke11!!")
        print("Connected successfully.\n")
        cursor = connection.cursor(dictionary = True, buffered=True)
        return connection, cursor
    except Exception as err:
        print("Error message: ", err)
   
# these functions presume that cursor and connection objects exist
        
def show_dbs(connection, cursor):
    show_db_query = """SHOW DATABASES;"""
    cursor.execute(show_db_query)
    dbs = cursor.fetchall()
    print("\nAvailable databases:")
    for db in dbs:
        print(db)
    print("\nDatabase in use:")
    print(connection.database)
    

    
def create_use_db(cursor, database):
    try:
        cursor.execute('''CREATE DATABASE '''+ database +''';''')
    except Exception as e:
        print(e)
        print("Trying again, deleting the db first ...")
        cursor.execute('''DROP DATABASE ''' + database + ''';''')
        cursor.execute('''CREATE DATABASE ''' + database +''';''')
    cursor.execute('''USE ''' + database + ''';''')


def show_table_cols(tables, cursor):
    try:
        for tbl_name in tables:
            cursor.execute('''SHOW COLUMNS FROM '''+ tbl_name +''';''')
            results = cursor.fetchall()
            print(tbl_name,"\n")
            print(pd.DataFrame(results))
            print("\n")

    except Exception as e:
        print(e)
    
    
def populate_little_lemon(connection, cursor):
    create_menuitem_table="""
    CREATE TABLE MenuItems (
    ItemID INT AUTO_INCREMENT,
    Name VARCHAR(200),
    Type VARCHAR(100),
    Price INT,
    PRIMARY KEY (ItemID)
    );"""

    create_menu_table="""
    CREATE TABLE Menus (
    MenuID INT,
    ItemID INT,
    Cuisine VARCHAR(100),
    PRIMARY KEY (MenuID,ItemID),
    FOREIGN KEY (ItemID) REFERENCES MenuItems (ItemID) ON DELETE CASCADE
    );"""

    create_booking_table="""
    CREATE TABLE Bookings (
    BookingID INT AUTO_INCREMENT,
    TableNo INT,
    GuestFirstName VARCHAR(100) NOT NULL,
    GuestLastName VARCHAR(100) NOT NULL,
    BookingSlot TIME NOT NULL,
    EmployeeID INT,
    PRIMARY KEY (BookingID)
    );"""

    create_orders_table="""
    CREATE TABLE Orders (
    OrderID INT,
    TableNo INT,
    MenuID INT,
    BookingID INT,
    BillAmount INT,
    Quantity INT,
    PRIMARY KEY (OrderID,TableNo)
    );"""
    
    tables = [create_menuitem_table, create_menu_table, create_booking_table, create_orders_table]
    
    for table in tables:
        cursor.execute(table)
        
    
    
    #*******************************************************#
    # Insert query to populate "MenuItems" table is:
    #*******************************************************#
    insert_menuitems="""
    INSERT INTO MenuItems (ItemID, Name, Type, Price)
    VALUES
    (1,'Olives','Starters',5),
    (2,'Flatbread','Starters', 5),
    (3, 'Minestrone', 'Starters', 8),
    (4, 'Tomato bread','Starters', 8),
    (5, 'Falafel', 'Starters', 7),
    (6, 'Hummus', 'Starters', 5),
    (7, 'Greek salad', 'Main Courses', 15),
    (8, 'Bean soup', 'Main Courses', 12),
    (9, 'Pizza', 'Main Courses', 15),
    (10,'Greek yoghurt','Desserts', 7),
    (11, 'Ice cream', 'Desserts', 6),
    (12, 'Cheesecake', 'Desserts', 4),
    (13, 'Athens White wine', 'Drinks', 25),
    (14, 'Corfu Red Wine', 'Drinks', 30),
    (15, 'Turkish Coffee', 'Drinks', 10),
    (16, 'Turkish Coffee', 'Drinks', 10),
    (17, 'Kabasa', 'Main Courses', 17);"""

    #*******************************************************#
    # Insert query to populate "Menu" table is:
    #*******************************************************#
    insert_menu="""
    INSERT INTO Menus (MenuID,ItemID,Cuisine)
    VALUES
    (1, 1, 'Greek'),
    (1, 7, 'Greek'),
    (1, 10, 'Greek'),
    (1, 13, 'Greek'),
    (2, 3, 'Italian'),
    (2, 9, 'Italian'),
    (2, 12, 'Italian'),
    (2, 15, 'Italian'),
    (3, 5, 'Turkish'),
    (3, 17, 'Turkish'),
    (3, 11, 'Turkish'),
    (3, 16, 'Turkish');"""

    #*******************************************************#
    # Insert query to populate "Bookings" table is:
    #*******************************************************#
    insert_bookings="""
    INSERT INTO Bookings (BookingID, TableNo, GuestFirstName, 
    GuestLastName, BookingSlot, EmployeeID)
    VALUES
    (1, 12,'Anna','Iversen','19:00:00',1),
    (2, 12, 'Joakim', 'Iversen', '19:00:00', 1),
    (3, 19, 'Vanessa', 'McCarthy', '15:00:00', 3),
    (4, 15, 'Marcos', 'Romero', '17:30:00', 4),
    (5, 5, 'Hiroki', 'Yamane', '18:30:00', 2),
    (6, 8, 'Diana', 'Pinto', '20:00:00', 5);"""

    #*******************************************************#
    # Insert query to populate "Orders" table is:
    #*******************************************************#
    insert_orders="""
    INSERT INTO Orders (OrderID, TableNo, MenuID, BookingID, Quantity, BillAmount)
    VALUES
    (1, 12, 1, 1, 2, 86),
    (2, 19, 2, 2, 1, 37),
    (3, 15, 2, 3, 1, 37),
    (4, 5, 3, 4, 1, 40),
    (5, 8, 1, 5, 1, 43);"""

    inserts = [insert_bookings, insert_menuitems, insert_menu, insert_orders]
    
    for insert in inserts:
        cursor.execute(insert)
        print("Total number of rows in table: {}\n".format(cursor.rowcount))
        connection.commit() # always commit after every insert, delete and update!
    
    
    cursor.execute("""SHOW TABLES;""")
    db_tables = cursor.fetchall()
    
    tbl_names = []
    for i in db_tables:
        for k, v in i.items():
            tbl_names.append(v)
        
    return tbl_names
