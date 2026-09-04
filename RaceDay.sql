
/* Matches: RaceDay ERD (Section A) and API Endpoint Plan (Section B) */

IF DB_ID('RaceDayDB') IS NULL
BEGIN
    CREATE DATABASE RaceDayDB;
END
GO

USE RaceDayDB;
GO

/* Drop tables if they already exist (in FK-safe order), so the script
can be re-run cleanly on the same instance during testing. */

IF OBJECT_ID('dbo.Results', 'U') IS NOT NULL DROP TABLE dbo.Results;
IF OBJECT_ID('dbo.Enrolments', 'U') IS NOT NULL DROP TABLE dbo.Enrolments;
IF OBJECT_ID('dbo.Categories', 'U') IS NOT NULL DROP TABLE dbo.Categories;
IF OBJECT_ID('dbo.Events', 'U') IS NOT NULL DROP TABLE dbo.Events;
IF OBJECT_ID('dbo.UserProfiles', 'U') IS NOT NULL DROP TABLE dbo.UserProfiles;
IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL DROP TABLE dbo.Users;
GO

/* TABLE: Users
Holds both Organisers and Participants, distinguished by Role. */

CREATE TABLE dbo.Users (
    UserId          INT IDENTITY(1,1)   NOT NULL,
    FullName        NVARCHAR(100)       NOT NULL,
    Email           NVARCHAR(150)       NOT NULL,
    PasswordHash    NVARCHAR(255)       NOT NULL,
    Role            NVARCHAR(20)        NOT NULL,
    CreatedAt       DATETIME2           NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT PK_Users PRIMARY KEY (UserId),
    CONSTRAINT UQ_Users_Email UNIQUE (Email),
    CONSTRAINT CK_Users_Role CHECK (Role IN ('Organiser', 'Participant'))
);
GO

/* TABLE: UserProfiles
Optional extended profile info. 1-to-0..1 with Users. */

CREATE TABLE dbo.UserProfiles (
    ProfileId           INT IDENTITY(1,1)  NOT NULL,
    UserId              INT                NOT NULL,
    PhoneNumber         NVARCHAR(20)       NULL,
    DateOfBirth         DATE               NULL,
    EmergencyContact    NVARCHAR(100)      NULL,
    ProfileImageUrl     NVARCHAR(255)      NULL,
    CONSTRAINT PK_UserProfiles PRIMARY KEY (ProfileId),
    CONSTRAINT UQ_UserProfiles_UserId UNIQUE (UserId),
    CONSTRAINT FK_UserProfiles_Users FOREIGN KEY (UserId)
        REFERENCES dbo.Users (UserId)
        ON DELETE CASCADE
);
GO

/* TABLE: Events
Created and owned by an Organiser (Users.Role = 'Organiser'). */

CREATE TABLE dbo.Events (
    EventId         INT IDENTITY(1,1)   NOT NULL,
    OrganiserId     INT                 NOT NULL,
    Name            NVARCHAR(150)       NOT NULL,
    Description     NVARCHAR(1000)      NULL,
    EventDate       DATE                NOT NULL,
    Location        NVARCHAR(150)       NOT NULL,
    CreatedAt       DATETIME2           NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT PK_Events PRIMARY KEY (EventId),
    CONSTRAINT FK_Events_Users FOREIGN KEY (OrganiserId)
        REFERENCES dbo.Users (UserId)
);
GO

