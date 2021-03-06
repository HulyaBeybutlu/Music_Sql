USE [Music]
GO
/****** Object:  Table [dbo].[Musics]    Script Date: 9/23/2020 8:07:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Musics](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MusicName] [nvarchar](100) NULL,
	[AuthorId] [int] NULL,
	[LaunchDate] [date] NULL,
	[Duration] [time](7) NULL,
	[GenreId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ListenedMusics]    Script Date: 9/23/2020 8:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ListenedMusics](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[MusicId] [int] NULL,
	[ListenDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ShowListenings]    Script Date: 9/23/2020 8:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ShowListenings] As
select mc.MusicName, Count(lst.MusicId)[ListenedMusicsCount] from ListenedMusics lst
Join Musics mc
on lst.MusicId=mc.Id
Group by mc.MusicName
GO
/****** Object:  Table [dbo].[LikedMusics]    Script Date: 9/23/2020 8:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LikedMusics](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[MusicId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ShowFavorites]    Script Date: 9/23/2020 8:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ShowFavorites] As
select mc.MusicName, COUNT(lm.MusicId)[LikedMusicsCount] from LikedMusics lm
Join Musics mc
on lm.MusicId=mc.Id
Group by mc.MusicName
GO
/****** Object:  Table [dbo].[Users]    Script Date: 9/23/2020 8:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[BirthDate] [date] NULL,
	[Email] [nvarchar](20) NULL,
	[Country] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ShowUserFavorites]    Script Date: 9/23/2020 8:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ShowUserFavorites] As
select us.FirstName, us.LastName, mc.MusicName from LikedMusics lm
 Join Musics mc
 on lm.MusicId = mc.Id
 Join Users us
 on lm.UserId = us.Id
GO
/****** Object:  Table [dbo].[Genres]    Script Date: 9/23/2020 8:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GenreName] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[GenresCount]    Script Date: 9/23/2020 8:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[GenresCount] As
 select  gs.GenreName, Count(mc.Id)[Music_count] from Musics mc
Join Genres gs
on mc.GenreId=gs.Id
Group by gs.GenreName
GO
/****** Object:  Table [dbo].[Authors]    Script Date: 9/23/2020 8:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authors](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[BirthDate] [date] NULL,
	[AuthorImage] [nvarchar](600) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Authors] ON 

INSERT [dbo].[Authors] ([Id], [FirstName], [LastName], [BirthDate], [AuthorImage]) VALUES (2, N'Rihanna', N'Fenty', CAST(N'1988-02-20' AS Date), NULL)
INSERT [dbo].[Authors] ([Id], [FirstName], [LastName], [BirthDate], [AuthorImage]) VALUES (3, N'Justin', N'Timberlake', CAST(N'1981-01-31' AS Date), NULL)
INSERT [dbo].[Authors] ([Id], [FirstName], [LastName], [BirthDate], [AuthorImage]) VALUES (4, N'Enrique', N'Iglesias', CAST(N'1979-10-14' AS Date), NULL)
INSERT [dbo].[Authors] ([Id], [FirstName], [LastName], [BirthDate], [AuthorImage]) VALUES (5, N'Taylor', N'Swift', CAST(N'1989-12-13' AS Date), NULL)
INSERT [dbo].[Authors] ([Id], [FirstName], [LastName], [BirthDate], [AuthorImage]) VALUES (6, N'Sezen', N'Aksu', CAST(N'1954-07-13' AS Date), NULL)
INSERT [dbo].[Authors] ([Id], [FirstName], [LastName], [BirthDate], [AuthorImage]) VALUES (7, N'Levent', N'Yuksel', CAST(N'1964-10-21' AS Date), NULL)
INSERT [dbo].[Authors] ([Id], [FirstName], [LastName], [BirthDate], [AuthorImage]) VALUES (8, N'Koray', N'Avci', CAST(N'1990-01-01' AS Date), NULL)
SET IDENTITY_INSERT [dbo].[Authors] OFF
GO
SET IDENTITY_INSERT [dbo].[Genres] ON 

INSERT [dbo].[Genres] ([Id], [GenreName]) VALUES (1, N'Rock')
INSERT [dbo].[Genres] ([Id], [GenreName]) VALUES (2, N'Pop')
INSERT [dbo].[Genres] ([Id], [GenreName]) VALUES (3, N'Jazz')
INSERT [dbo].[Genres] ([Id], [GenreName]) VALUES (4, N'Hip hop')
INSERT [dbo].[Genres] ([Id], [GenreName]) VALUES (5, N'Classical music')
SET IDENTITY_INSERT [dbo].[Genres] OFF
GO
SET IDENTITY_INSERT [dbo].[LikedMusics] ON 

INSERT [dbo].[LikedMusics] ([Id], [UserId], [MusicId]) VALUES (1, 1, 5)
INSERT [dbo].[LikedMusics] ([Id], [UserId], [MusicId]) VALUES (2, 1, 4)
INSERT [dbo].[LikedMusics] ([Id], [UserId], [MusicId]) VALUES (3, 2, 6)
INSERT [dbo].[LikedMusics] ([Id], [UserId], [MusicId]) VALUES (4, 2, 9)
INSERT [dbo].[LikedMusics] ([Id], [UserId], [MusicId]) VALUES (5, 2, 1)
INSERT [dbo].[LikedMusics] ([Id], [UserId], [MusicId]) VALUES (6, 3, 12)
INSERT [dbo].[LikedMusics] ([Id], [UserId], [MusicId]) VALUES (7, 3, 4)
INSERT [dbo].[LikedMusics] ([Id], [UserId], [MusicId]) VALUES (8, 4, 10)
INSERT [dbo].[LikedMusics] ([Id], [UserId], [MusicId]) VALUES (9, 4, 2)
INSERT [dbo].[LikedMusics] ([Id], [UserId], [MusicId]) VALUES (10, 5, 5)
INSERT [dbo].[LikedMusics] ([Id], [UserId], [MusicId]) VALUES (11, 5, 3)
INSERT [dbo].[LikedMusics] ([Id], [UserId], [MusicId]) VALUES (12, 5, 4)
INSERT [dbo].[LikedMusics] ([Id], [UserId], [MusicId]) VALUES (13, 6, 11)
INSERT [dbo].[LikedMusics] ([Id], [UserId], [MusicId]) VALUES (14, 6, 8)
SET IDENTITY_INSERT [dbo].[LikedMusics] OFF
GO
SET IDENTITY_INSERT [dbo].[ListenedMusics] ON 

INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (1, 1, 2, CAST(N'2020-08-10' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (2, 1, 12, CAST(N'2018-02-05' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (3, 1, 4, CAST(N'2020-05-14' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (4, 2, 10, CAST(N'2019-06-08' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (5, 2, 3, CAST(N'2019-06-11' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (6, 2, 2, CAST(N'2017-03-19' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (7, 2, 11, CAST(N'2020-01-05' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (8, 3, 1, CAST(N'2020-01-05' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (9, 3, 5, CAST(N'2020-05-15' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (10, 3, 9, CAST(N'2020-01-05' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (11, 4, 6, CAST(N'2020-01-05' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (12, 4, 9, CAST(N'2020-02-29' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (13, 4, 1, CAST(N'2020-01-05' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (14, 4, 7, CAST(N'2020-01-05' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (15, 5, 8, CAST(N'2020-01-05' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (16, 5, 12, CAST(N'2020-01-05' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (17, 6, 10, CAST(N'2020-04-23' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (18, 6, 1, CAST(N'2020-01-05' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (19, 6, 12, CAST(N'2020-04-20' AS Date))
INSERT [dbo].[ListenedMusics] ([Id], [UserId], [MusicId], [ListenDate]) VALUES (20, 6, 3, CAST(N'2020-06-14' AS Date))
SET IDENTITY_INSERT [dbo].[ListenedMusics] OFF
GO
SET IDENTITY_INSERT [dbo].[Musics] ON 

INSERT [dbo].[Musics] ([Id], [MusicName], [AuthorId], [LaunchDate], [Duration], [GenreId]) VALUES (1, N'Hos geldin', 8, CAST(N'2016-06-16' AS Date), CAST(N'00:04:29' AS Time), 2)
INSERT [dbo].[Musics] ([Id], [MusicName], [AuthorId], [LaunchDate], [Duration], [GenreId]) VALUES (2, N'Gidiyorum', 8, CAST(N'2020-09-08' AS Date), CAST(N'00:04:19' AS Time), 2)
INSERT [dbo].[Musics] ([Id], [MusicName], [AuthorId], [LaunchDate], [Duration], [GenreId]) VALUES (3, N'Ihanetten geri kalan', 6, CAST(N'2017-03-13' AS Date), CAST(N'00:03:57' AS Time), 5)
INSERT [dbo].[Musics] ([Id], [MusicName], [AuthorId], [LaunchDate], [Duration], [GenreId]) VALUES (4, N'Diamonds', 2, CAST(N'2013-11-20' AS Date), CAST(N'00:04:43' AS Time), 4)
INSERT [dbo].[Musics] ([Id], [MusicName], [AuthorId], [LaunchDate], [Duration], [GenreId]) VALUES (5, N'Needed me', 2, CAST(N'2016-08-17' AS Date), CAST(N'00:03:13' AS Time), 1)
INSERT [dbo].[Musics] ([Id], [MusicName], [AuthorId], [LaunchDate], [Duration], [GenreId]) VALUES (6, N'MedCezir', 7, CAST(N'2011-01-18' AS Date), CAST(N'00:04:34' AS Time), 2)
INSERT [dbo].[Musics] ([Id], [MusicName], [AuthorId], [LaunchDate], [Duration], [GenreId]) VALUES (7, N'Blank space', 5, CAST(N'2015-11-02' AS Date), CAST(N'00:04:33' AS Time), 4)
INSERT [dbo].[Musics] ([Id], [MusicName], [AuthorId], [LaunchDate], [Duration], [GenreId]) VALUES (8, N'Shake it off', 5, CAST(N'2014-05-05' AS Date), CAST(N'00:04:02' AS Time), 1)
INSERT [dbo].[Musics] ([Id], [MusicName], [AuthorId], [LaunchDate], [Duration], [GenreId]) VALUES (9, N'Hero', 4, CAST(N'2010-07-19' AS Date), CAST(N'00:04:22' AS Time), 1)
INSERT [dbo].[Musics] ([Id], [MusicName], [AuthorId], [LaunchDate], [Duration], [GenreId]) VALUES (10, N'Heart attack', 4, CAST(N'2014-04-22' AS Date), CAST(N'00:03:51' AS Time), 3)
INSERT [dbo].[Musics] ([Id], [MusicName], [AuthorId], [LaunchDate], [Duration], [GenreId]) VALUES (11, N'Mirrors', 3, CAST(N'2013-02-10' AS Date), CAST(N'00:08:21' AS Time), 3)
INSERT [dbo].[Musics] ([Id], [MusicName], [AuthorId], [LaunchDate], [Duration], [GenreId]) VALUES (12, N'Tukenecegiz', 6, CAST(N'2017-12-04' AS Date), CAST(N'00:04:19' AS Time), 5)
SET IDENTITY_INSERT [dbo].[Musics] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [BirthDate], [Email], [Country]) VALUES (1, N'Hulya', N'Beybutlu', CAST(N'1998-11-19' AS Date), N'hulya@gmail.com', N'Azerbaijan')
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [BirthDate], [Email], [Country]) VALUES (2, N'Lamiye', N'Beybutova', CAST(N'1999-09-26' AS Date), N'lamis@gmail.com', N'Azerbaijan')
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [BirthDate], [Email], [Country]) VALUES (3, N'Gunay', N'Agayeva', CAST(N'1991-02-14' AS Date), N'gunay@mail.ru', N'Georgia')
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [BirthDate], [Email], [Country]) VALUES (4, N'Ali', N'Arslan', CAST(N'1997-04-18' AS Date), N'ali@hotmail.com', N'Turkey')
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [BirthDate], [Email], [Country]) VALUES (5, N'Leon', N'Wilson', CAST(N'1989-10-10' AS Date), N'leon@gmail.com', N'Great Britain')
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [BirthDate], [Email], [Country]) VALUES (6, N'Kate', N'Dymond', CAST(N'1992-05-19' AS Date), N'kate@mail.ru', N'Canada')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[LikedMusics]  WITH CHECK ADD FOREIGN KEY([MusicId])
REFERENCES [dbo].[Musics] ([Id])
GO
ALTER TABLE [dbo].[LikedMusics]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[ListenedMusics]  WITH CHECK ADD FOREIGN KEY([MusicId])
REFERENCES [dbo].[Musics] ([Id])
GO
ALTER TABLE [dbo].[ListenedMusics]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Musics]  WITH CHECK ADD FOREIGN KEY([AuthorId])
REFERENCES [dbo].[Authors] ([Id])
GO
ALTER TABLE [dbo].[Musics]  WITH CHECK ADD FOREIGN KEY([GenreId])
REFERENCES [dbo].[Genres] ([Id])
GO
