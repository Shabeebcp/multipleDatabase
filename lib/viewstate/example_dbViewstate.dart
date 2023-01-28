// import 'package:external_path/external_path.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:path/path.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:ppos_van_sales/Services/DataBase/IDatabaseService.dart';
// import 'package:ppos_van_sales/Services/services.dart';
// import 'package:ppos_van_sales/core/AppData/shared_preference.dart';
// import 'dart:io' as io;

// import 'package:sqflite/sqflite.dart';

// class DBViewState extends ChangeNotifier {
//   late IDatabaseService databaseService;
//   DBViewState() {
//     databaseService = Services.databaseService;
//   }
//   Database? _databaseNow;
//   Database? _defaultDb;
//   Database? _accountsDb;
//   Future<Database?> get accountsDb async {
//     if (_accountsDb == null) {
//       _accountsDb = await initializeDatabase(
//           folderName: "POLOSYS", dbName: 'Accounts.db');
//       return _accountsDb;
//     } else {
//       return _accountsDb;
//     }
//   }

//   Future<Database?> defaultDatabse() async {
//     if (_defaultDb == null) {
//       _defaultDb = await initializeDatabase(
//           folderName: "POLOSYS", dbName: 'MasterDB.db');
//       return _defaultDb;
//     } else {
//       return _defaultDb;
//     }
//   }

//   Future<Database?> databseNow({String? folderName, String? dbName}) async {
//     if (_databaseNow == null) {
//       _databaseNow =
//           await initializeDatabase(folderName: "POLOSYS", dbName: dbName);
//       return _databaseNow;
//     } else {
//       return _databaseNow;
//     }
//   }

//   Future initializeDatabase({String? folderName, String? dbName}) async {
//     return await _init(foldName: folderName, dbName: dbName);
//   }

//   Future<Database> _init({String? foldName, String? dbName}) async {
//     await createFolder(folderName: foldName);

//     // var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
//     var path = await ExternalPath.getExternalStorageDirectories();
//     String? dbPath = join(path[0].toString(), foldName, dbName);
//     if (dbName == 'Accounts.db') {
//       final db = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
//       return db;
//     } else {
//       final db = await openDatabase(dbPath,
//           version: 16, onCreate: _onCreateOther, onUpgrade: _onUpgradeOther);
//       return db;
//     }

//     // if (await io.Directory(path[0].toString() + "/POLOSYS").exists() != true) {
//     //   try {
//     //     print('create createSync');
//     //     io.Directory(path[0].toString() + "/POLOSYS")
//     //         .createSync(recursive: true);
//     //   } catch (e) {
//     //     print('create exception');
//     //     io.Directory(path[0].toString() + "/POLOSYS").create();
//     //   }
//     // } else {
//     //   print("Directoryexist");
//     // }
//   }

//   Future createFolder({String? folderName}) async {
//     try {
//       Map<Permission, PermissionStatus> statuses = await [
//         Permission.location,
//         Permission.manageExternalStorage,
//         Permission.accessMediaLocation,
//         Permission.storage,
//         Permission.camera
//       ].request();
//     } catch (e) {
//       print(e.toString());
//     }
//     var path = await ExternalPath.getExternalStorageDirectories();
//     if (await io.Directory('${path[0].toString()}/$folderName').exists()) {
//       io.Directory('${path[0].toString()}/$folderName').createSync();
//     } else {
//       await io.Directory('${path[0].toString()}/$folderName').create();
//     }
//   }

//   _onCreate(Database? db, int? version) async {
//     version = 1;
//     await db!.execute(_accounts);
//   }

//   _onCreateOther(Database? db, int? version) async {
//     version = 1;
//     db!
//       ..execute(_versionSettings)
//       ..execute(_settings)
//       ..execute(_companyInfo)
//       ..execute(_employees)
//       ..execute(_users)
//       ..execute(_defaultUser)
//       ..execute(_accLedgers)
//       ..execute(_salesRoute)
//       ..execute(_units)
//       ..execute(_brands)
//       ..execute(_products)
//       ..execute(_productPrices)
//       ..execute(_priceCategory)
//       ..execute(_billNos)
//       ..execute(_invTransMaster)
//       ..execute(_invTransDetails)
//       ..execute(_accTransaction)
//       ..execute(_lastTransactions)
//       ..execute(_visitArea)
//       ..execute(_salesShift)
//       ..execute(_clientDevice)
//       ..execute(_expense);
//     if (SharedPrefs.settingsValues.CompanyName == 'BISMILOCALTEST') {
//       db.execute(_vehicle); //new update test 21_10_2022 [Bismi]
//     }
//   }

//   static void _onUpgradeOther(
//       Database db, int oldVersion, int newVersion) async {
//     for (var i = oldVersion; i <= newVersion; i++) {
//       if (i > oldVersion) {
//         switch (i) {
//           case 2:
//             break;
//           case 3:
//             await db.execute("ALTER TABLE InvTransMaster ADD COLUMN GUID text");
//             await db.execute(
//                 "ALTER TABLE InvTransMaster ADD COLUMN KSA_Inv_QR_Code text");
//             await db.execute(
//                 "ALTER TABLE InvTransMaster ADD COLUMN NewInvoiceNumber int");
//             break;
//           case 4:
//             await db.execute(
//                 "ALTER TABLE InvTransMaster ADD COLUMN IsDraft INTEGER DEFAULT 0");
//             break;
//           case 5:
//             await db.execute(
//                 "ALTER TABLE Settings ADD COLUMN MaintainKSAEInvoice nvarchar(25)");
//             break;
//           case 6:
//             await db.execute(
//                 "ALTER TABLE Products ADD COLUMN ProductBatchID INTEGER");
//             break;
//           case 7:
//             await db.execute(
//                 "ALTER TABLE AccLedgers ADD COLUMN Address2 nvarchar(50)");
//             break;
//           case 8:
//             await db.execute(
//                 "ALTER TABLE AccLedgers ADD COLUMN Address3 nvarchar(50)");
//             await db.execute(
//                 "ALTER TABLE AccTransaction ADD COLUMN NewInvoiceNumber nvarchar(50)");
//             break;
//           case 9:
//             await db.execute(
//                 "ALTER TABLE InvTransMaster ADD COLUMN TaxOnDiscount double");
//             break;
//           case 10:
//             await db.execute(
//                 "ALTER TABLE Products ADD COLUMN IsDiscountable nvarchar(6)");
//             break;
//           case 11:
//             await db.execute(
//                 "ALTER TABLE InvTransMaster ADD COLUMN RoundOffAmount double");
//             break;
//           case 12: //new update 07_03_2022
//             await db.execute(
//                 "CREATE TABLE IF NOT EXISTS Expense(ExpenseID integer primary key autoincrement,Description nvarchar(200),Amount double)");
//             break;
//           case 13: //new update 11_04_2022
//             await db.execute(
//                 "ALTER TABLE Products ADD COLUMN HSNCode nvarchar(10)");
//             break;
//           case 14: //new update 30_06_2022
//             await db.execute(
//                 "ALTER TABLE AccLedgers ADD COLUMN Remarks nvarchar(250)");
//             break;
//           case 15: //new update 30_06_2022
//             await db.execute(
//                 "ALTER TABLE AccTransaction ADD COLUMN IsDraft INTEGER DEFAULT 0");
//             break;
//           case 16: //new update 14_12_2022
//             db.execute(
//                 "ALTER Table AccLedgers ADD COLUMN IsActive nvarchar(6) DEFAULT 'true'");
//             db.execute(
//                 "ALTER Table AccLedgers ADD COLUMN IDType nvarchar(20)  NULL");
//             db.execute(
//                 "ALTER Table AccLedgers ADD COLUMN IDNumber nvarchar(20) NULL");
//             db.execute(
//                 "ALTER Table AccLedgers ADD COLUMN ArabicName nvarchar(250)  NULL");
//             db.execute(
//                 "ALTER Table AccLedgers ADD COLUMN PlotIdentificationNumber nvarchar(50) NULL");
//             db.execute(
//                 "ALTER Table AccLedgers ADD COLUMN BuildingNumber nvarchar(50)  NULL");
//             db.execute(
//                 "ALTER Table AccLedgers ADD COLUMN CitySubDivision nvarchar(50) NULL");
//             db.execute(
//                 "ALTER Table AccLedgers ADD COLUMN PostalCode nvarchar(50)  NULL");
//             db.execute(
//                 "ALTER Table AccLedgers ADD COLUMN Country nvarchar(50) NULL");
//             db.execute(
//                 "ALTER Table AccLedgers ADD COLUMN CountrySubEntity nvarchar(50) NULL");

//             break;
//           default:
//         }
//       }
//     }
//   }

// ////[-------------------Accounts.db Database--------------------------]
//   final String _accounts = """ Create Table Accounts 
//       ( 
//         Id INTEGER PRIMARY KEY, 
//         BusinessName Text , 
//         ProductSerial Text , 
//         ContactEmail Text ,
//         IsDefault int,
//         DatabaseName Text  
//       )  """;

//   ///[-------------------------------------------------------------------]
//   final String _invTransMaster = '''CREATE TABLE InvTransMaster 
//         ( InvMasterID integer primary key autoincrement, 
//        InvType nvarchar(20), 
//        VrPrefix nvarchar(20), 
//        FormType nvarchar(20), 
//        PartyName nvarchar(100), 
//        TransDate datetime, 
//        TotTax double, 
//        CashRcvd double, 
//        BankAmt double,
//        BillDiscPerc double, 
//        BillDisc double, 
//        UserID INTEGER, 
//        GrandTotal double, 
//        EmplD INTEGER,
//        BillNo nvarchar(50), 
//        LedgerID INTEGER, 
//        IsConverted nvarchar(5), 
//        Status nvarchar(10),
//        SalesShiftID INT NULL,
//        LocationLatitude nvarchar(25) NULL,
//        LocationLongitude nvarchar(25) NULL,
//        GPSLocationName nvarchar(200),
//        CreatedDateTime nvarchar(50) null,
//        Tot_SchemeDiscount double,
//        Tot_SGST double,
//        Tot_CGST double,
//        Tot_IGST double,
//        Tot_Cess double,
//        Tot_AddionalCess double,
//        Tot_CalamityCess double,
//        Tot_TCS double,
//        Tot_TDS double,
//        IsUpdated nvarchar(5),
//        Remarks nvarchar(100),
//        NewInvoiceNumber INTEGER NULL,
//        KSA_Inv_QR_Code text,
//        GUID text,
//        IsDraft INTEGER DEFAULT 0,
//        TaxOnDiscount double,
//        RoundOffAmount double
//        )''';
//   final String _invTransDetails = '''CREATE TABLE InvTransDetails 
//         (InvDetailsID integer primary key autoincrement, 
//        InvMasterID INTEGER, 
//        ProductID INTEGER, 
//        Qty nvarchar(50), 
//        MRP double default 0,
//        Free INTEGER,
//        Rate DOUBLE, 
//        Disc DOUBLE, 
//        Amount DOUBLE, 
//        Unit nvarchar(10), 
//        UnitID int default 0,
//        TaxPerc DOUBLE, 
//        Tax DOUBLE,
//        PrintSequence INTEGER,
//        Total DOUBLE,
//        CessPerc DOUBLE,
//        CessAmt DOUBLE,
//        SGSTPerc DOUBLE,
//        SGST DOUBLE,
//        CGSTPerc DOUBLE,
//        CGST DOUBLE,
//        IGSTPerc DOUBLE,
//        IGST DOUBLE,
//        CalamityCessPerc DOUBLE,
//        CalamityCess DOUBLE,
//        AdditionalCessPerc DOUBLE,
//        AdditionalCess DOUBLE)''';
//   final String _employees = '''CREATE TABLE Employees 
//         (EmpID INTEGER NOT NULL, 
//        EmpCode nvarchar(20), 
//        EmpName text)''';
//   final String _companyInfo = '''CREATE TABLE CompanyInfo 
//         (CompanyMasterID INTEGER NOT NULL, 
//        CompanyName nvarchar(100), 
//        Address1 nvarchar(100), 
//        Address2 nvarchar(100), 
//        Phone nvarchar(12),
//        Mobile nvarchar(12), 
//        ContactNo nvarchar(12))''';
//   final String _brands = '''CREATE TABLE Brands 
//         (BrandID INTEGER NOT NULL, 
//        BrandName nvarchar(30))''';
//   final String _users = '''CREATE TABLE Users 
//         ( UserID INTEGER NOT NULL, 
//        UserName nvarchar(50), 
//        Pwd nvarchar(50), 
//        Status nvarchar(10))''';
//   final String _salesRoute = '''CREATE TABLE SalesRoute 
//         ( RouteID INTEGER, 
//        RouteName nvarchar(30))''';
//   final String _accLedgers = '''CREATE TABLE AccLedgers 
//         ( CompanyLedgersID INTEGER, 
//        LedgerID INTEGER, 
//        LedgerCode nvarchar(20), 
//        LedgerName nvarchar(500), 
//        GroupName nvarchar(50), 
//        Address1 nvarchar(200),
//        Address2 nvarchar(200),
//        Address3 nvarchar(200),
//        TIN nvarchar(30), 
//        CST nvarchar(30), 
//        Phone nvarchar(12), 
//        Email nvarchar(30), 
//        Balance DOUBLE, 
//        FormType nvarchar(10), 
//        RouteID INTEGER,
//        CreditDays INTEGER,
//        CreditAmount DOUBLE,
//        PriceCategoryID INTEGER,
//          LocationLatitude nvarchar(25) NULL,
//          LocationLongitude nvarchar(25) NULL,
//          LocationName nvarchar(200),
//          ChangeStatus varchar(1),
//        CreatedDateTime nvarchar(50) null,
//        DbChangeID INTEGER,
//        Remarks nvarchar(250),
//        IsActive nvarchar(6) DEFAULT 'true',
//        IDType nvarchar(20)  NULL,
//        IDNumber nvarchar(20)  NULL,
//        ArabicName nvarchar(250)  NULL,
//        PlotIdentificationNumber nvarchar(50)  NULL,
//        BuildingNumber nvarchar(50)  NULL,
//        CitySubDivision nvarchar(50)  NULL,
//        PostalCode nvarchar(50)  NULL,
//        Country nvarchar(50)  NULL,
//        CountrySubEntity nvarchar(50) NULL)'''; //New update test 30_06_2022[ Remark Column Added ]
//   final String _accTransaction = '''CREATE TABLE AccTransaction 
//         ( AccTransID integer primary key autoincrement, 
//        LedgerID INTEGER NOT NULL, 
//        TransType nvarchar(20), 
//        VrPrefix nvarchar(20), 
//        FormType nvarchar(20), 
//        BillNo nvarchar(20), 
//        NewInvoiceNumber nvarchar(20), 
//        TransDate datetime, 
//        Amount double,
//        DiscAmt double, 
//        EmpID INTEGER, 
//        Narration nvarchar(50), 
//        UserID INTEGER, 
//        Status nvarchar(30),
//        SalesShiftID INT NULL,
//        LocationLatitude nvarchar(25) NULL,
//        LocationLongitude nvarchar(25) NULL,
//        GPSLocationName nvarchar(200),
//        CreatedDateTime nvarchar(50) null, 
//        IsUpdated nvarchar(5),
//        ChequeNumber nvarchar(20),
//        ChequeDate datetime,
//        IsDraft INTEGER DEFAULT 0 )'''; //new update 29_10_2022 [isDraft Column in AccTransaction]
//   final String _products = '''CREATE TABLE Products 
//         ( ProductID INTEGER NOT NULL, 
//         ProductBatchID INTEGER,
//        ProductCode nvarchar(20), 
//        ProductName nvarchar(500), 
//        GroupName nvarchar(40), 
//        BrandID INTEGER,
//        SPrice double, 
//        PPrice double, 
//        MRP double, 
//        VatP double, 
//        CessP double,
//        SGSTPerc double,
//        CGSTPerc double,
//        IGSTPerc double,
//        CessPerc double,
//        AddCessPerc double,
//        CalamityCessPerc double,
//        Disc nvarchar(100),
//        SoldQty double,
//        RtQty double,
//        OrdQty double,
//        Specification nvarchar(40),
//        Batch nvarchar(40),
//        MannualBarcode nvarchar(40),
//        AutoBarcode nvarchar(10),
//        DbChangeID INTEGER,
//        IsActive nvarchar(6),
//        ItemNameInSecondLanguage nvarchar(500),
//        UnitID INTEGER, 
//        MinSalePrice double, 
//        Stock double,
//        IsDiscountable nvarchar(6),
//        HSNCode nvarchar(10))
//        '''; //VanStock
//   final String _settings = '''CREATE TABLE Settings 
//         ( ProductSerial nvarchar(20), 
//        MasterDBID nvarchar(20),
//        ActivationDate datetime, 
//        DownloadDate datetime, 
//        UploadDate datetime, 
//        ExpiryDate datetime, 
//        DeviceID nvarchar(20), 
//        SendEmail nvarchar(6),
//        SendSMS nvarchar(6), 
//        AutoSync nvarchar(6), 
//        SyncInterval nvarchar(50), 
//        PrintCollection nvarchar(6), 
//        PrintOrder nvarchar(6), 
//        PrintSales nvarchar(6), 
//        PrintReturn nvarchar(6), 
//        CompanyName nvarchar(80), 
//        Address1 nvarchar(80), 
//        Address2 nvarchar(80), 
//        Tin nvarchar(80), 
//        Phone nvarchar(80), 
//        MachineCode nvarchar(10), 
//        Email nvarchar(100), 
//        EmailPswd nvarchar(50), 
//        IsThermalPrinter nvarchar(6), 
//        PrinterColumnCount nvarchar(3), 
//        Footer nvarchar(80), 
//        HideNonstockItems nvarchar(6), 
//        A4Printing nvarchar(6), 
//        A5Printing nvarchar(6), 
//       PrintHeaders nvarchar(6),
//       ShowVatSales nvarchar(6),
//       ShowSales nvarchar(6),
//       TopMargin INTEGER,
//       LeftMargin INTEGER,
//       BlueToothDeviceName nvarchar(50),
//       ShowOB nvarchar(6),
//       PrintArabic nvarchar(6),
//       ShowLinesBetweenItems nvarchar(6),
//       PrintArabicProductName nvarchar(6),
//       UniqueInvoiceNumberFormat nvarchar(6),
//       EnableSalesOrderEdit nvarchar(6),
//       TopMarginSO INTEGER,
//       ItemPerPageSO INTEGER,
//       ItemPerPage INTEGER,
//       BlockPriceEditing nvarchar(6),
//       BlockItemDiscountEditing nvarchar(6),
//       BlockFreeEditing nvarchar(6),
//       BlockBillDiscountEditing nvarchar(6),
//       BlockPriceBelowMinSalesPrice nvarchar(6),
//       BlockPriceAboveMaxSalesPrice nvarchar(6),
//       BlockOnCreditLimit nvarchar(6),
//       MaxPricePercentage double,
//        RoundBillAmount nvarchar(6),
//       TaxType nvarchar(15),
//       CustomerSelectionMethod nvarchar(25),
//       ProductType nvarchar(25),
//       MaintainKSAEInvoice nvarchar(25)
//        )''';
//   final String _units = '''CREATE TABLE Units 
//         (UnitID INTEGER NOT NULL, 
//        ProductID INTEGER, 
//        Unit nvarchar(10), 
//        MultiFactor nvarchar(10),
//        DbChangeID Integer)''';
//   final String _productPrices = '''CREATE TABLE ProductPrices 
//         (ProductBatchID INTEGER NOT NULL, 
//        UnitID INTEGER, 
//        PriceCategoryID INTEGER, 
//        Price double, 
//        DbChangeID Integer)''';

//   final String _lastTransactions = '''CREATE TABLE LastTransactions 
//         ( LedgerID integer, 
//        TransType nvarchar(20), 
//        TDate datetime, 
//        Amount double, 
//        VochurNo nvarchar(50), 
//        Narration nvarchar(100))''';
//   final String _visitArea = '''CREATE TABLE VisitArea 
//         ( EmpID nvarchar(50), 
//        VisitDateTime datetime, 
//        Latitude nvarchar(150), 
//        Longitude nvarchar(150), 
//        Status nvarchar(10), 
//        AreaName nvarchar(100) )''';
//   final String _billNos = '''
// CREATE TABLE BillNos 
//       (TransType nvarchar(20), 
//       FormType nvarchar(20), 
//       LastBillNo INTEGER,
//       Prefix nvarchar(20)  )''';
//   final String _versionSettings = '''CREATE TABLE VersionSettings 
//         ( VersionNo integer)''';
//   final String _defaultUser =
//       '''CREATE TABLE DefaultUser (Uname nvarchar(50), Pwd nvarchar(50))''';
//   final String _salesShift = '''CREATE TABLE SalesShift(
//     MasterDBID int,
//     BranchID int,DeviceID nvarchar(25) ,
//     SalesShiftID INTEGER primary key AUTOINCREMENT,
//     ShiftDate date,
//     ShiftOpenTime datetime,
// ShiftCloseTime datetime,
// ShiftStatus nvarchar(1),
// OpenUserID int,
// ClosedUserID int,
// StartOdoMeter int,
// EndOdoMeter int,
// Fuel nvarchar(10),
// OpenedLocationLatitude nvarchar(25),
// OpenedLocationLongitude nvarchar(25),
// ClosedLocationLatitude nvarchar(25),
// ClosedLocationLongitude nvarchar(25),
// Remarks nvarchar(50), IsUpdated nvarchar(5))''';
//   final String _clientDevice = """ CREATE TABLE IF NOT EXISTS ClientDevices 
//         (DeviceID INTEGER NOT NULL, 
//        DeviceCode nvarchar(100), 
//        DeviceNameID nvarchar(100), 
//        DeviceDescription nvarchar(100), 
//        IsActive nvarchar(6),
//        Status nvarchar(10), 
//        NextResetDate datetime,
//        CreatedDate datetime) """;

//   final String _priceCategory = """CREATE TABLE IF NOT EXISTS PriceCategory
//             (
//               PriceCategoryID Integer NOT NULL primary key,
//               BranchID bigint NOT NULL,
//               PriceCategoryName nvarchar(80) NOT NULL,
//               DiscountPerc DOUBLE
//             )""";
// //new update test 07_03_2022
//   final String _expense = """ 
// CREATE TABLE IF NOT EXISTS Expense(
//   ExpenseID integer primary key autoincrement,
//   Description nvarchar(200),
//   Amount double
// )
// """;
// //new update test 21_10_2022 [Bismi]
//   final String _vehicle = """CREATE TABLE Vehicle ( 
//        VehicleID INTEGER NOT NULL, 
//        VehicleName nvarchar(50), 
//        VehicleNumber nvarchar(50) ) """;
// }
