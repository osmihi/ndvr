-- djcalculator baseline data
DELETE FROM `smihi83_ndvr`.`ProjectSkill`;
DELETE FROM `smihi83_ndvr`.`WorkSkill`;
DELETE FROM `smihi83_ndvr`.`EducationSkill`;

DELETE FROM `smihi83_ndvr`.`Example`;
DELETE FROM `smihi83_ndvr`.`Task`;

DELETE FROM `smihi83_ndvr`.`Skill`;
DELETE FROM `smihi83_ndvr`.`Project`;
DELETE FROM `smihi83_ndvr`.`Work`;
DELETE FROM `smihi83_ndvr`.`Education`;

DELETE FROM `smihi83_ndvr`.`Contact`;
DELETE FROM `smihi83_ndvr`.`Profile`;
DELETE FROM `smihi83_ndvr`.`Portfolio`;
DELETE FROM `smihi83_ndvr`.`SkillCategory`;
DELETE FROM `smihi83_ndvr`.`User`;

-- User
INSERT INTO `User` (`username`, `password`, `email`) VALUES ('osmihi', SHA1('password'), 'othman@osmihi.com');
SET @userID = LAST_INSERT_ID();

-- Portfolio
INSERT INTO `Portfolio` (`userID`, `name`, `createdDate`) VALUES (@userID, 'Software Developer Portfolio', NOW());
SET @portfolioID = LAST_INSERT_ID();

-- Profile
INSERT INTO `Profile` (`portfolioID`, `firstName`,`middleName`,`lastName`,`title`,`location`,`statement`) VALUES
  (@portfolioID, 'Othman', 'Mohamed-Shahid', 'Smihi', 'Software Engineer', 'Minneapolis, MN', 'Software Engineer and Analyst enthusiastic about designing and building web applications');

-- Contact
INSERT INTO `Contact` (`portfolioID`, `type`, `subType`, `contact`, `label`) VALUES
  (@portfolioID, 'phone', 'cell', '651-353-8981', NULL),
  (@portfolioID, 'email', NULL, 'othman@osmihi.com', NULL),
  (@portfolioID, 'web', 'github', 'http://www.github.com/osmihi', 'GitHub'),
  (@portfolioID, 'web', 'linkedin', 'https://www.linkedin.com/pub/othman-smihi/4a/aab/354', 'LinkedIn'),
  (@portfolioID, 'web', 'ndvr', '/#/osmihi', 'Portfolio');

-- Education
INSERT INTO `Education` (`portfolioID`, `name`, `location`, `startDate`, `endDate`, `program`, `gpa`, `honors`) VALUES
  (@portfolioID, 'University of Minnesota', 'Minneapolis, MN', '2002-09-01', '2006-05-01', 'B.A. Sociology', 3.6, ''),
  (@portfolioID, 'Institute of Production and Recording', 'Minneapolis, MN', '2006-06-01', '2007-12-15', 'A.A.S. Audio Production and Engineering', 4.0, 'Valedictorian'),
  (@portfolioID, 'Metropolitan State University', 'St. Paul, MN', '2011-06-01', '2013-08-15', 'B.S. Computer Science', 3.95, 'Summa Cum Laude');

SET @eduUM = (SELECT `educationID` FROM `Education` WHERE `name` = 'University of Minnesota');
SET @eduIPR = (SELECT `educationID` FROM `Education` WHERE `name` = 'Institute of Production and Recording');
SET @eduMetro = (SELECT `educationID` FROM `Education` WHERE `name` = 'Metropolitan State University');

-- Work
INSERT INTO `Work` (`portfolioID`, `name`, `location`, `title`, `startDate`, `endDate`) VALUES
  (@portfolioID, 'Hinata LLC', 'Richfield, MN', 'Web Developer, Managing Member', '2010-01-01', '2012-12-31'),
  (@portfolioID, 'Infinite Campus', 'Blaine, MN', 'Software Engineer Intern', '2012-05-01', '2012-08-31'),
  (@portfolioID, 'Infinite Campus', 'Blaine, MN', 'Software Product Analyst - Technical', '2012-09-01', '2014-02-28'),
  (@portfolioID, 'Infinite Campus', 'Blaine, MN', 'Software Engineer', '2014-03-01', NULL);

SET @workHinata = (SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC');
SET @workICSEI = (SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title`='Software Engineer Intern');
SET @workICSPA = (SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title`='Software Product Analyst - Technical');
SET @workICSE = (SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title`='Software Engineer');

-- Task
INSERT INTO `Task` (`workID`, `seq`, `description`) VALUES
  (@workICSE, '1', 'Design, maintain, and debug Java, JavaScript (jQuery, AngularJS), and XSL code of enterprise web app'),
  (@workICSE, '2', 'Serve as lead developer on project, introducing team to Scrum workflow and coordinating planning efforts'),
  (@workICSE, '3', 'Refactor code to increase maintainability, performance, cross-browser compatibility and documentation'),
  (@workICSE, '4', 'Design and update schema of an extensive relational database; write and debug complex SQL queries'),
  (@workICSE, '5', 'Facilitate and promote meaningful collaboration with developers, analysts, product managers, and others'),
  (@workICSPA, '1', 'Analyze complex problems, conduct research, and engage with users to engineer detailed requirements'),
  (@workICSPA, '2', 'Conceptualize, design and deliver future-minded features & user interfaces to satisfy business drivers'),
  (@workICSPA, '3', 'Effectively communicate with stakeholders including end-users, clients, management & CEO'),
  (@workICSPA, '4', 'Develop product fixes and enhancements by writing JavaScript, Java, XSL, HTML, and CSS code'),
  (@workHinata, '1', 'Develop web sites and applications using PHP, JavaScript/jQuery with AJAX, HTML, and CSS'),
  (@workHinata, '2', 'Communicate with clients to meet requirements and deliver quality work complete and on time');

-- Project
-- (insert with workID or educationID where applicable)
INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, NULL, '10', '0', 'ID3 tagger for radio network', 'Windows shell script to automate ID3 tagging of MP3 archives', 'I created a script and corresponding database to write proper id3 tags for a radio network''s complete podcast archive');
SET @projRadioID3 = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, NULL, '20', '0', 'Radio traffic audit system', 'Log file parser used to verify that all scheduled advertisements played on air', 'I created a script that parses through the logfile created by a radio station''s traffic system, assembles a report outlining which specific files played, then e-mailing that report to interested parties.');
SET @projRadioAudit = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, NULL, '30', '0', 'Automated podcast publishing/archive system', 'Windows shell script(s) to backup and publish recordings for a national radio network', 'I created a fully automated system for a radio network to archive and publish podcasts of their 30-40 radio shows just minutes after they air.');
SET @projRadioArchive = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '0', NULL, NULL, '40', '0', 'Drum machine / vocoder', 'Drum machine, beat sequencer with vocoder build in Native Instruments Reaktor', '<p>This is a drum machine with an integrated synthesizer/vocoder that I made using Native Instruments Reaktor 5. It can be a pretty fun useful tool for enhancing bland beats and creating rhythmic synth parts. Below is the original documentation. If you''d like to try it out (you''ll need a copy of NI Reaktor 5) you can download the file <a href="/projects/reaktorDrum/Othman_reaktorDrum.zip">here</a>:<blockquote><a href="/projects/reaktorDrum/Othman_reaktorDrum.zip">Othman_reaktorDrum.zip</a></blockquote></p><h3>Othman''s Drum/Synth/Sequencer Thing, Version 1.0</h3><p>This patch consists of a 16-step sequencer for triggering up to 8 drum samples, which may in turn independently trigger (or more accurately, gate) three individual oscillators. The oscillators each have their own filter, LFO, and "note chooser" among other things. An external input is also available for triggering the oscillators. Finally, there is a delay with feedback and lowpass filter. The patch is self-contained and does not make use of external MIDI yet.</p><p>At the top left, there are 8 display boxes that show the filenames of the loaded samples. Double click on a box to open its properties then click on the little waveform picture to load samples. Each sample has a control for pan, level and pitch, and 4 send levels. There is a 9th box that is for the external input, which has a level indicator, gain, and highpass filter, and 3 sends.</p><p>Each column of knobs in the sends area corresponds to a destination for the sample. The first three columns are for oscillators one, two, and three, respectively, and the fourth goes to the delay. The external input doesn''t have a send for the delay because it is only used as a trigger (gate). All sends are pre-fader.</p><p>The top right section of the panel is where the sequencer lives. It''s pretty straight-forward, with each button representing a 16th note. Also, there''s a row of indicator lights at the bottom of the sequencer grid that lights up during playback in time with the movement of the grid.</p><p>There are three oscillator sections at the bottom of the panel. They are all identical, except that oscillator one lacks the "slave" button. At the far left of the oscillator section, you will find the note chooser, where you can choose a chromatic note from the list. To the right of the note chooser is a knob which controls the octave of the chosen note, which is displayed beneath. Above this knob is a fader for the level of the oscillator. Above the fader is a selector to determine the waveshape for the oscillator: sine, sawtooth, pulse, and white noise. There''s a knob to control width when pulse is selected.</p><p>To the right of the fader, there''s a pan pot. To the right of the octave knob, you will find the filter for the oscillator. There are frequency and resonance knobs, and a selector to toggle between highpass, bandpass, and lowpass filters. To the right of these filter controls are the LFO parameters including rate, amount, and shape. Shapes include sine, triangle, square, and off (to deactivate the LFO). The LFO will automatically adjust the filter frequency above and below the point set on the frequency knob.</p><p>The remaining controls in the oscillator section include mode, release, groove, and ?Dly. The ?Dly knob, found in the top right corner of the box sends the oscillator''s output to the delay processor. The Mode selector toggles between envelope mode and sustained mode. In envelope mode, the sum of audio sent to the oscillator (from the drums and/or external input) is used to modulate the amplitude of the oscillator, creating a triggered or gated effect. This is what you will want to use most of the time. In sustained mode, the oscillator just runs constantly. This isn''t that useful, but can be fun to switch back and forth during playback.</p><p>The release knob determines how long it takes for the oscillator''s amplitude to recover from peaks when operating in envelope mode. Short release is good for fast, percussive sounds, and longer release is good for bass sounds, etc.</p><p>The "groove" controls are useful in creating different rhythms out of the triggered oscillators. The -/+ selector determines how many steps the triggered signal will be offset forward in time. The groove control, though simple, can help enliven an otherwise boring creation. The button beneath the groove selector will add an offset of 1 step (one 16th note) only while it is held down. This is fun to mess with during playback.</p><p>You might notice that oscillators 2 and 3 also have a "slave" button, which is not present on oscillator 1. When engaged, the output of that oscillator is sent into oscillator one''s filter, bypassing its own filter and pan, but keeping its pitch, shape, release, and groove setting. It will be processed by the osc 1''s filter, and will also be affected by osc 1''s groove setting.</p><p>The delay controls can be found on the right side of the panel, towards the bottom. This is pretty self-explanatory. You can select the delay time (measured in steps, or 16th notes) using the list. The top knob controls the level of the delay return. The middle knob controls how much of the delay''s output is fed back into its input. The third knob adjusts the cutoff frequency of a lowpass filter applied to the output of the delay (pre-feedback).</p><p>Finally, the bottom right corner of the panel contains three very important controls. The "Run" button will start and stop playback. The adjacent knob is the master volume. Below these two is the tempo slider, which ranges from 60bpm to 200bpm.</p>');
SET @projDrumVocoder = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, @workHinata, '50', '0', 'Águila de Esperanza website', 'Informational web site with interactive survey and reporting', 'This is a small site I built for a local business that connects American students with their Guatemalan counterparts. The site was needed with very little turnaround (several days) and had to include an online survey that visitors could take. I used PHP and a simple MySQL database to create the survey, and a few bits of Javascript to create some visuals for when the administrator wanted to view the results.');
SET @projAguila = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '0', NULL, NULL, '60', '0', 'Home recording studio', 'Recording studio in my home', '<p>These are some pictures from my project studio in Minneapolis. This is where most of the recording, mixing, and experimentation go on for the projects I''m involved with.</p><p>It''s nothing to rival any big-time studio of course, but I believe that making good music has less to do with how much money you have and more with how much care and effort you put in.</p><p>That''s not to say I haven''t built up a nice selection of instruments, microphones, and recording gear. Take a minute to check things out, you might be surprised.</p>');
SET @projStudio = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '0', NULL, NULL, '70', '0', 'Sound clip player for radio producers', 'News clip and sound effect player for use during live radio broadcasts', '<p>This is another instrument / ensemble I built in Native Instruments Reaktor 5. As a producer in talk radio, I often found that it was difficult to stay organized and react quickly when playing sound effects and audio clips during live broadcasts. Every fraction of a second is critical, and the system that I was given was costing us plenty. </p><p>I created this device to solve a number of problems. It provides instantaneous access to ten clips at a time, plus 3 short sound fx, and one-click access to additional pages of audio. Also, users are able to easily color-code any of their audio elements to aid in organization (i.e. what has been played so far, or type of content) as well as view a visual representation of the clip, helping to anticipate drops and or spikes in volume. Finally, users can cue up a clip to any point without putting out any sound on-air, or they can even seek through the clip live on-air quickly and easily, for maximum efficiency and smoothness during broadcasts.</p><p>If you''d like to use this tool for your own radio show or podcast, or just want to check it out, you''ll need a copy of NI Reaktor 5, and you can download the file here:<blockquote><a href="projects/reaktorClip/OthmanClipPlayer.ens">OthmanClipPlayer.ens</a></blockquote></p>');
SET @projReaktorClip = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, @workHinata, '80', '0', 'Collaborative story-writing web app', 'A web app to help creative teams collaborate when writing scripts or other stories', '<p>This is a site / web-based application I created that helps writers outline and write stories either on their own or in collaboration with other writers. This was my first real endeavor into creating a dynamic database-driven web application, and it is written in PHP and utilizes a MySQL database backend. Features include permissions, versioning, and a unique architecture for collaboratively writing and editing stories from the ground up.</p><h4>Story Site</h4><h5>Chronological System</h5><p>A story contains chapters, chapters contain scenes, and scenes contain pages. Any object that is located on a page is also located in a scene. That scene, in turn, is located within a chapter, which is located within a story. In this way, anything with a location is part of a given story. Within a given scene, each object in that scene has a unique page. This is how definite chronological order is achieved. Chapters, scenes, and page numbers may be changed at any time. This doesn''t disrupt the ownership because things are linked via GlobalIDs, rather than the numbers of the scenes, etc. It does, however, allow us to rearrange scenes and chapters, pages, etc. Characters and Settings are not part of the chronological system. They can be drawn from and linked to certain other objects (lines and scenes, respectively) but are free of being chained to any particular story, chapter, scene, or page.</p><h5>Permissions System</h5><p>A story has an owner. That owner can add users to a list of those who may edit objects within the story. Also, the owner adds characters and settings to their respective lists: StChar - which characters may appear in the story, and StSett - which settings may be used in the story. So, as we mentioned earlier, Characters and Settings exist outside of a story (though they are sure to be used within stories). They are at the same point in the hierarchy as the story itself. This way, the same people and places are used in different stories very easily and consistently. Characters and Settings also have Editors. If a person has permission to edit a story, their editing rights do not carry over onto the character itself. In order to be able to edit a character or setting, they need to be an editor on that character or setting, NOT just on a story that it exists in.</p><h5>Versioning System</h5><p>When a change is made to an object, rather than literally making those changes to its database entry, what actually happens is that it is cloned, then the changes are made to that clone. After this is done, the previous version is assigned a new GlobalID, which is entered into the new version''s PrevID field, and its Active field is set to 0. The Author and Created fields remain the same for all generations, but the Editor and Modified fields are reset to the user doing the changes when a new version is made. New versions will be made when changes are made to the Content field.</p><h5>Comments System</h5><p>Comments are attached to objects via GlobalID. If comments are to be displayed for a given object, a time/date-sorted list is displayed of comments that are tied to that object. Remember, the -current- version of an object has the all-time GlobalID, so old comments still appear.</p><h5>Tags System</h5><p>Tags are allowed on any of the objects except for comments (and users). This allows flexibility in the system for groups collaborating on a project to be able to organize the content and workflow in a more customized way. For instance, an editor could skim through a story and tag various objects as "revise", and "complete". Then they could prioritize going through to fix all the "revise" bits, then mark them as "complete" when done. A search can be done under any of the normal criteria (i.e. story, text, etc) but adding a search for the tags field allows a nicer way to enable specific searching if desired. Story owners have an option to hide tags from all but editors.</p>');
SET @projTale = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '0', NULL, NULL, '90', '0', 'Electronic music remix / performance instrument', 'Sophisticated multi-purpose digital audio sample/loop manipulation tool', '<p>This project is a digital musical instrument I created from scratch using Native Instruments Reaktor 5 software. The basic idea behind it is to allow a unique, flexible, and very musical way to manipulate various melodic and rhythmic samples or loops in a real-time performance. Essentially, users of this instrument can load in some samples or loops, either those of a related set (i.e. the various beats and samples of an existing song) or a hodge podge of unrelated materials, and easily combine them in any number of ways to create a remix on the fly.</p><p>The instrument features eight sampler modules, four different sequencers, several unique effects, two inline delay modules, three separate stereo audio busses, and a handful of other goodies.</p><p>Users can "chop" and rearrange samples via any of the four sequencers using two distinct types of interface via the sequencing page. These templates are then applied to any or all of the samples/loops that have been loaded into the instrument at the user''s will, and can be changed on the fly. </p><p>Each of the samples can be assigned to either the A, B, or C audio busses, allowing quick and easy "mute group"-like functionality. Each bus routes through its own independent repeater module (though they can be chained together) which is constantly recording and playing back a user-set amount of musical time and can be triggered to replace the audio stream at any moment, truncated, repeated itself, and even played back in reverse. Any of the included effects modules have switches for engaging bus A and/or B, while bus C is the "isolation" bus that does not go to any of the effects modules or repeaters.</p><p>The effects included in the instrument provide unique twists on classic effects. The dynamic distortion is set by the user to adjust its frequency range and level of distortion based on the amplitude of the incoming signal, producing interesting results particularly on percussive elements. The cutter provides a horizontal grid where the user can toggle a series of time segments on or off, then apply these to the amplitude envelope of a given bus in various ways. The CutnPaste effect is another type of inline delay that is able to repeatedly replace a portion of a bus'' audio signal with another portion of it, similar to the inline delay on some high end DJ mixers, or the "Beat Repeat" effect in Ableton Live. </p><p>Finally, the Table Filter effect shows a grid which the user can either draw in with the mouse, or manually set via a knob on the screen or MIDI controller. The curve drawn in this grid is then repeated over a user-chosen interval and then applied to the filter envelope of an audio bus, resulting in a looped filter effect. Of course, the most fun is had when combining all these different effects together, and in conjunction with the various sequencer functions.</p><p>Of course, it''s always much better to try things first hand than to simply hear about it, so if you''d like to try it out for yourself (you''ll need a copy of NI Reaktor 5) you can download the ensemble & some sample loops here:<blockquote><a href="http://www.osmihi.com/projects/reaktorHouse/reaktorHouse.zip">reaktorHouse.zip</a></blockquote></p>');
SET @projReaktorRemix = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, @workHinata, '100', '0', 'Job search helper web app', 'A simple web app that I used to stay organized during a job search', '<p>This is a web application that I made in my spare time to help me stay organized while searching for jobs. The problem I was having was that, between the different college job boards, craigslist, various employment websites, individual companies, and traditional print ads, it was becoming impossible to keep track of what listings I''d liked and to stay focused.</p><p>So I created a database that would house the various relevant information for a given job listing, i.e. job title, company, URL, contact info, and any notes I had. I also made sure I could categorize the jobs and assign a priority, or level of interest to each. As soon as some or all of this information is entered, it is viewable in a chart alongside any other listings I''ve entered into the system.</p><p>From this chart, I can update the information, sort by category or by priority, and with one click mark which ones I''ve applied to and/or heard back from. This allows me to glance at one screen and get an idea of what progress I''ve made, and also helps me make sure I''m not letting an opportunity I might be interested in slip by.</p><p>This has proven a more reliable strategy than the handwritten notes and e-mails to myself that I had been using before.</p><p>Another issue I came across was that, since I wasn''t always doing my searching from the same computer, I didn''t consistently have access to my set of job-search bookmarks/favorites. This problem inspired me to add another section to the application where I could simply store and organize my various weblinks, enabling me to have convenient access from anywhere. Also, rather than simply creating a list of links like most browsers do, I thought it might be more useful in this specific situation to have a hierarchy of links. This way I could add a link for a general site like craigslist, for instance, and then place links to its specific sections as children beneath it. I''ve found this works well for saving specific search terms on sites, so I can just check back at the various URLs I''ve saved without having to reconstruct each search every time I''m poking around for new listings.</p><p>I later incorporated another feature to help make things more efficient. Despite the generally clean workflow of the site, it was starting to feel a little cumbersome to enter information for each listing when adding more than a couple listings at a time. The solution that I found was to find a way to simply drag and drop the URL of the listing into a field, and then as soon as I click "Submit" to let the app take care of the rest. Given a url, the app will retrieve the information contained in the title tag of the page and save that into the record. A subtle improvement, yes, but cutting out some of that extra hassle enables one to focus more on the actual task at hand.</p><p>This web application provides a simple drag-and-drop interface to centralize all job search prospects, progress, and resources in one place with minimal effort. Most importantly, however, I was able to learn some new tricks and techniques while making my job hunt a little less routine.</p>');
SET @projJobs = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, @workHinata, '110', '0', 'Hinata notes app', 'An all-purpose list-making / note-taking web application', '<p>This was my favorite application I built for Hinata LLC. It functions like a virtual notebook, allowing you to store, edit, organize and display notes and ideas flexibly and naturally. </p><p>I used this application just about every day for a while, and still continue to use it to this day, although I see many opportunities for improvement. It''s been a great tool for keeping my thoughts and plans organized for the various projects and creative endeavors I''m working on at any given time.INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES\n  (<em>note: if you log in to the demo account given below, there is some explanation in the site itself</em>)</p><p>For the brave and curious, you''re welcome to make an account and play with the app, which can currently be found at<blockquote><a href="http://idea2.osmihi.com" target="_blank">idea2.osmihi.com</a></blockquote>From there, you can login using username "demo" and password "test" to take a quick look around, or make your own account and start using the site!</p>');
SET @projIdea2 = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, @workHinata, '120', '0', 'osmihi.com', 'Personal website and content management system', '<p>One project of mine that I can share with you is my old website. Aside from all the (hopefully informative and entertaining) content you find here, I also designed & built the site and its underlying infrastructure. </p><p>Rather than making a bunch of static HTML pages that need to be hand edited whenever changes are to be made, I decided to create a lean, custom, highly specialized content management system (CMS) specifically for my purposes on this site. If I want to add a new song or music category, a new blog post or piece of writing, or a project for the ''projects'' page, all I need to do is go into my super-secret administrative page and add it there via a quick and easy web-based interface. From there, the rest is taken care of automatically.</p><p>Aside from making it easy to update, some other nice features are present that can''t be done with a traditional, static site. For one, I can tag any of my blogs, pieces of writing, or project entries with any term I like and do a simple search for that term later and pull up any and all entries that match it. Also, I can add any number of different pictures to a project entry and its page will be formatted accordingly. And just for fun, I''ve made it so each time you visit the project page a new random photo will be chosen from the set of associated pictures for each project and displayed beside it. Finally, the music page makes use of AJAX techniques to dynamically load content from the server in response to user input without reloading the page altogether.</p><p>The custom CMS for osmihi.com is written in PHP and relies upon a MySQL database to store the site''s content. Furthermore, a lot of the little bells and whistles (including the AJAX pieces) make use of Javascript. Because I have designed it specifically to do exactly what I need it to (no more and no less) it is relatively lightweight and easy to maintain. At first I considered using a larger, already established CMS like Drupal or Wordpress, but while the flexibility and massive array of features is always attractive, I ultimately decided to go with a smaller and more specialized solution. </p>');
SET @projOsmihi = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', @eduMetro, NULL, '130', '0', 'Android RSS Feed Reader / Scraper', 'Android application utilizing web search API to scrape for RSS feeds on a given topic', 'A friend and I wanted to get into Android development, so we started by writing a simple app that deals with RSS and Atom feeds. A user enters some search criteria and the app plugs into the Blekko web search API to find some results. The app filters down those results and then scans for RSS or Atom feeds on those pages and verifies that the documents are indeed valid feeds. <br /><br />This was a great introduction to programming a basic Android app. We had a lot of fun working with the web search API, manipulating the XML/HTML content of web pages and RSS feeds, and refactoring our code repeatedly.<br /><br />You can browse the source code at <a href="https://github.com/osmihi" target="_blank">GitHub</a>.');
SET @projRSS = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, @workICSPA, '137', '0', 'Analysis for enhancements, bugs, and maintenance of enterprise web app', 'Business analysis, requirements elicitation and UI/UX design of features', '');
SET @projAnalyst = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', @eduMetro, NULL, '140', '0', '8-bit RPG Battle Game', 'Original Nintendo-style battle simulation role playing game written in Java', '<p>This is a project I did while taking the Elementary Data Structures course in my computer science degree program. We were asked to make a simulation of some kind and, being a big fan of old-school Nintendo role playing games, I thought it would be a good opportunity to see if I could create my own game in that style.</p><p>The program was written in the Java language, using Swing for the GUI components. Originally a desktop application, I adapted it to run as an applet after the fact. The <a href="https://github.com/osmihi/com.osmihi.battle" target="_blank">source code</a> for the desktop version is up on <a href="https://github.com/osmihi/com.osmihi.battle" target="_blank">GitHub</a> and can be found <a href="https://github.com/osmihi/com.osmihi.battle" target="_blank">here</a>.</p><p>I created all the artwork for the game also. Not that I expect anyone to be impressed by that, just thought it was worth mentioning :)</p><p><strong>You can play the game through your web browser via the applet on <a href="http://www.osmihi.com/battle" target="_blank">this page:</a></strong></p><p><a href="http://www.osmihi.com/battle" target="_blank">http://www.osmihi.com/battle</a></p><p>(Just a heads up, it can take about 5 seconds to load the battle screen, so please be patient.)</p><div style="border-bottom: 1pt solid black; width: 100%;"></div><p><em>note: the Java applet will require Java 6 or newer to be installed. Chances are you already have it on your computer, but if not, you can download the latest version of Java <a href="http://www.java.com/getjava" target="_blank">here</a>:</em></p><p><a href="http://www.java.com/getjava" target="_blank">Get Java</a></p>');
SET @projBattle = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, @workICSPA, '145', '0', 'School counselor caseload dashboard and management tool', 'Product enhancement to aggregate student data and display in context', '<p>On this project, I engaged with users to elicit requirements, designed a solution and validated & tested the results. The analysis that I did for this project has proven to have lasting value for the company and has been used as an example for others.</p>');
SET @projCaseload = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', @eduMetro, NULL, '150', '0', 'Operating Systems synchronization project', 'Java project utilizing complex operating systems concepts like synchronization to simulate the logistics of product delivery', '');
SET @projCleo = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, @workICSE, '153', '1', 'General development of enterprise web app', 'Software development of new features, bug fixes, and maintenance to student information system web application', '<p>The general workload of a developer on a large, complex and aging web application involves working with a large amount of legacy code and data. Bug fixes and maintenance span the range from urgent, high-priority issues to routine maintenance tasks. This work also includes implementing enhancements to existing features, data conversion, schema and object design, and long-term planning.</p><p>As a Software Engineer in this position, I completed over 100 issues, working with a variety of technologies and striving to improve code quality not only in terms of functionality but also readability, testability, and overall maintainability.</p>');
SET @projICDev = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, @workICSE, '156', '0', 'Document revision tracking and management solution', 'Enhancement to document editing framework to enable detailed tracking of amendments', '<p>My contributions to this project include:<ul><li>Front end development</li><li>Back end development</li><li>Solution concept</li></ul></p><p>On this project, I implemented a modification to an existing workflow that tracks users'' modifications to specific areas of interactive documents in a web application.</p><p>One of the challenges of this project was that it involved using jQuery to build on top of an existing established UI. This provided an opportunity to see both the potential and the pitfalls of extensive DOM manipulation.</p>');
SET @projAmend = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', @eduMetro, NULL, '160', '0', 'OrdrUpApp.com', 'Web application and Android app for management of orders, food preparation, and bills in restaurants', '<p>This is the group capstone project I did during my Computer Science education. Here''s the blurb:</p><blockquote>OrDrUp is a fully integrated restaurant management system that seamlessly coordinates table management, order taking, and food preparation so that the owners and staff can concentrate on what’s most important: their customers.</blockquote><p>OrDrUp consists of a web app and an Android app, both of which are supported by a RESTful API. The only library that we really used was jQuery, so this was an excellent chance to show our full understanding of the architecture from top to bottom.</p><p>My contributions to this project include:</p><ul><li>Architecture design</li><li>Design and full implementation of RESTful API (PHP)</li><li>Implementation of all other server-side functionality (PHP)</li><li>Front end web development (Javascript / jQuery)</li><li>Requirements analysis</li><li>Logo & graphic design (such as it is)</li></ul><h5>Links</h5><ul><li>View the code on <a href="https://github.com/osmihi/Capstone">GitHub</a> - "Capstone" repo</li><li>Visit the <a href="http://www.ordrupapp.com/">main site</a> (log in as user "bootsy.collins" with password "password"</li><li><a href="http://www.ordrupapp.com/reset.php">Reset</a> the database to baseline</li></ul>');
SET @projOrdrUp = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, @workICSPA, '170', '0', 'Meetings management integrated web application', 'Integrated web application for scheduling, managing, and reporting on meetings in schools', '<p>My contributions to this product include:<ul><li>Functional requirements</li><li>UI design</li><li>Collaborator on wireframes</li><li>Presentations (CEO, end-users, internal stakeholders)</li><li>Research and engagement with end users</li><li>Practice agile methodologies</li><li>Domain research</li><li>Competitive analysis</li><li>Diagramming</li><li>Schema design</li><li>Testing and validation</li></ul></p><p>This was a large project on which I served as the Analyst. I consider it a great success because the development team and I were able to turn what was originally a loosely defined (and perhaps ill-fated) project into a highly successful endeavor that has been used as an example in many ways for other subsequent projects.</p><p>On this project, in addition to the requirements, UI design, and other typical activities, I was able to get some great experience (and very positive results) engaging with a wide variety of stakeholders, both internal and external. This includes a presentation to the CEO, an internal stakeholder presentation which was so well-received that another chief executive requested that I give it a second time so that it could be recorded and used as an example in the company.</p><p>Understanding a product''s users is always key when trying to build effective and profitable software, and on this project I had the opportunity to conduct a wide variety of research including surveys, interviews, usability testing, external issue testings</p><p>The resulting product was a success and has thus far been used heavily by the customers who received it. Meanwhile, expansion of the tool is planned in multiple areas.</p>');
SET @projMeetings = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, @workHinata, '175', '0', 'ChrisAndOthman.com', 'Web application for wedding guest registration with its own API and interactive RSVP form', '<p>I built this website / mini-app in a few days in order to facilitate guests RSVP''ing to my wedding. I designed the site to have elements of responsive design, so that it could adapt to both a standard browser and mobile devices. I utilized the twitter bootstrap library to help in this respect.</p><p>The RSVP form is structured in a way that loads progressively as users provide more information. This is accomplished via a series of ajax calls using jQuery. The form itself is written with HTML5 in order to leverage some of its built-in form features, such as required fields and so on.</p><p>The code is viewable on <a href="https://github.com/osmihi">GitHub</a> and you can still visit the site at <a href="http://www.chrisandothman.com/">chrisandothman.com</a>.</p>');
SET @projRSVP = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, @workICSPA, '177', '0', 'Meeting scheduler', 'Research, analysis and product design for a set of tools to facilitate complex scheduling scenarios', '<p>My contributions to this project include:<ul><li>Business Analysis</li><li>Solution concept</li><li>Competitive analysis</li><li>Requirements gathering</li><li>Diagramming</li><li>Presentation</li></ul></p><p>For this project, I researched and designed a set of tools to fulfill some of the future goals of Product Management.</p><p>The work involved extensive research and analysis into existing solutions, as well as general requirements gathering in order to come up with a full and complete set of user stories. From these stories, I designed the product to fulfill their needs while leveraging existing functionality as well as positioning the overall product for other future enhancements.</p>');
SET @projMeetingScheduler = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, @workICSE, '180', '1', 'Checklist document editing and reproduction solution', 'Implementation of a practical, maintainable solution for creating XML definitions of documents and generating user interfaces and printed documents', '<p>My contributions to this project include:<ul><li>Front end development</li><li>Back end development</li><li>Solution concept</li><li>Schema design</li></ul></p><p>This project involved implementing a solution within an existing application that would allow a variety of state-issued forms with widely varying content to be stored and reproduced, with the contents of individual instances modifiable by users.</p><p>Traditionally, within this application developers code a set of UI forms to input data, then code a similar set of forms to support the generation of a PDF printout of the completed form. What was different about the solution that I implemented was that each document is defined in XML, and then a transform is applied on either the front- or back-end in order to generate the UI code or XSL-FO (PDF-generating) code, respectively.</p><p>The project was well-received for its flexibility and ease of maintenance, and was used as the template for at least one other future project in the department.</p>');
SET @projChecklist = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, NULL, '187', '0', 'ReadID3 Javascript library', 'Javascript library used to read information from ID3 tags from MP3 files directly in the browser', '<p>My contributions to this project include:<ul><li>Understanding ID3 standard (multiple versions)</li><li>Porting Java code to Javascript</li><li>Reading and interpreting binary data from files using Javascript</li></ul></p><p>While working on djCalculator.com, I wanted to implement a feature that would allow users to import the metadata from the ID3 tags in MP3 files. While there are many implementations of ID3 tag readers available, they are most often in server-side languages. Given that djCalculator is a JavaScript-based web app, it made much more sense to create a library capable of perform this function that is native to the browser.</p><p>Developing this code involved researching and understanding the ID3 standard (multiple versions) reading binary data from files, and converting Java code to Javascript.</p><p>Epilogue: After discovering another, more robust Javascript library that accomplishes the same task, I set aside this project and instead implemented the other library in the djCalculator application. I did, however, modify the other library to improve its error handling.</p>');
SET @projReadID3 = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, NULL, '190', '1', 'djCalculator.com', 'Web application for DJs built using AngularJS with a RESTful API back-end written in PHP', '<p>My contributions to this project include:<ul><li>Front end development</li><li>Back end development</li><li>RESTful API Design and Implementation</li><li>Product concept</li><li>Architecture</li><li>UI Design</li></ul></p><p>djCalculator.com is a web application that I created using AngularJS (front end) and PHP (RESTful API back end). The app allows users to manage a library of music and plan DJ sets by matching the relative pitch of subsequent tracks.</p><p>Some notable features currently offered by the app include drag and drop sorting and management of tracks, import of track metadata from MP3 files directly in the browser via JavaScript, instantaneous search/filtering of track lists, and automated "suggestion" of tracks, based on relative pitch and tempo.</p><p>This project is still under development, and the code is available on <a target="_blank" href="https://github.com/osmihi/djCalc">GitHub</a>. Please check it out if you''re interested.</p>');
SET @projDjCalc = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, @workICSE, '196', '1', 'Learner Planning Document Editor Application', 'Modular application for viewing and editing complex regulated Special Education documents, with AngularJS front-end', '<p>My contributions to this project include:<ul><li>Lead developer on project</li><li>Front end development</li><li>Back end development</li><li>Initial research and solution design</li><li>Coordination of agile planning sessions</li><li>Schema design</li><li>Collaborator on UI design</li></ul></p><p>This was a large project to introduce a new app module built with AngularJS into an existing web application. Technologies used on this project besides Angular include: Underscore, RequireJS, Sass, jQuery, Java, SQL, XML, XSLT, JSON, HTML, and CSS.</p><p>During the early stages of this project, I did research and analysis to come up with the overall solution to the problem of how to capture, edit, and report on a wide array of complex data traditionally represented in paper forms. Once development began, I worked as a Software Engineer to design and build the application.</p><p>It can be challenging to successfully integrate modern web technologies with a legacy application, but the rewards are numerous. The foundation of the back end of this app was as an adapter class that would accept any of a variety of legacy document formats and allow our app to interact with them uniformly.This project also necessitated browser support back to IE8, so that provided some tricky problems to solve on the front end as well.</p>');
SET @projPWN = LAST_INSERT_ID();

INSERT INTO `Project` (`portfolioID`, `display`, `educationID`, `workID`, `seq`, `active`, `name`, `summary`, `description`) VALUES
  (@portfolioID, '1', NULL, NULL, '200', '1', 'ndvr.co - Portfolio sharing web app', 'Resume and portfolio sharing web application written using AngularJS', '<p>My contributions to this project include:<ul><li>Front end development</li><li>Product concept</li><li>Requirements analysis</li><li>Schema design</li><li>Architecture</li><li>UI design</li></ul></p><p>ndvr.co is a web application that I created in less than a week in October 2014 in order to be able to easily put together and share my portfolio and resume. In fact, <strong>this very portfolio</strong> was created and is viewable at <a target="_blank" href="http://ndvr.co/#/osmihi">ndvr.co/#/osmihi</a>.</p><p>The app is written using JavaScript using the AngularJS and Underscore frameworks, and heavily utilizies Twitter Bootstrap for styling. Users can actually swap out different themes from Bootswatch to get a different look if they like.</p><p>At this time, static JSON files are used to serve the data. This was done in order to meet the "Minimum Viable Project" requirement I set on a Wednesday night, which was that I should be able to successfully present a resume and portfolio using the app by Monday. That being said, the app is structured as a platform to be used by many users. In the future, I plan to add a back-end to the site and open it up for use by anyone, but for now it simply serves my own content and functions as a conversation piece and a demonstration of some knowledge.</p><p>All of the project''s code and analysis artifacts are available on <a target="_blank" href="https://github.com/osmihi/ndvr">GitHub</a>. Please check it out if you''re interested.</p>');
SET @projNdvr = LAST_INSERT_ID();

-- Example
INSERT INTO `Example` (`projectID`, `type`, `seq`, `link`, `description`) VALUES
  (@projAguila, 'image', 1, '/img/osmihi/aguila.png', 'Aguila de Esperanza home page');

INSERT INTO `Example` (`projectID`, `type`, `seq`, `link`, `description`) VALUES
  (@projJobs, 'image', 1, '/img/osmihi/jobs.png', 'Entry form for a new job listing');

INSERT INTO `Example` (`projectID`, `type`, `seq`, `link`, `description`) VALUES
  (@projIdea2, 'image', 1, '/img/osmihi/idea2.png', 'Infinitely nestable lists help keep organized');

INSERT INTO `Example` (`projectID`, `type`, `seq`, `link`, `description`) VALUES
  (@projOsmihi, 'image', 1, '/img/osmihi/osmihi.png', 'osmihi.com Studio photo gallery');

INSERT INTO `Example` (`projectID`, `type`, `seq`, `link`, `description`) VALUES
  (@projBattle, 'image', 1, '/img/osmihi/battle.png', 'Title screen of the Battle Game');

INSERT INTO `Example` (`projectID`, `type`, `seq`, `link`, `description`) VALUES
  (@projOrdrUp, 'image', 1, '/img/osmihi/ordrup.png', 'Touch screen display for the kitchen');

INSERT INTO `Example` (`projectID`, `type`, `seq`, `link`, `description`) VALUES
  (@projMeetings, 'image', 1, '/img/osmihi/meetings.png', 'A modal dialog previewing notifications');

INSERT INTO `Example` (`projectID`, `type`, `seq`, `link`, `description`) VALUES
  (@projRSVP, 'image', 1, '/img/osmihi/chrisandothman.png', 'Welcome/Info page for wedding guests');

INSERT INTO `Example` (`projectID`, `type`, `seq`, `link`, `description`) VALUES
  (@projMeetingScheduler, 'image', 1, '/img/osmihi/scheduler.png', 'Process workflow for the Meeting Scheduler');

INSERT INTO `Example` (`projectID`, `type`, `seq`, `link`, `description`) VALUES
  (@projDjCalc, 'image', 1, '/img/osmihi/djcalc.png', 'djCalculator web app');

INSERT INTO `Example` (`projectID`, `type`, `seq`, `link`, `description`) VALUES
  (@projNdvr, 'image', 1, '/img/osmihi/ndvr.png', 'My portfolio on ndvr.co (this site)');


-- SkillCategory
INSERT INTO `SkillCategory` (`type`,`name`) VALUES
  ('skills','Programming Languages'),
  ('skills','Web Technologies'),
  ('skills','Design'),
  ('skills','Software'),
  ('accomplishments','Accolades'),
  ('accomplishments','Leadership'),
  ('accomplishments','Credentials');

-- Skill
INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Programming Languages'), 10, 'Java');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `EducationSkill` (`educationID`, `skillID`, `seq`) VALUES
  ((SELECT `educationID` FROM `Education` WHERE `name`='Metropolitan State University'), @skillID, 0);

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 0),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 0),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer Intern'), @skillID, 0),
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 0);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Android RSS Feed Reader / Scraper'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='8-bit RPG Battle Game'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Operating Systems synchronization project'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Document revision tracking and management solution'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Checklist document editing and reproduction solution'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ReadID3 Javascript library'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 0);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Programming Languages'), 20, 'JavaScript');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `EducationSkill` (`educationID`, `skillID`, `seq`) VALUES
  ((SELECT `educationID` FROM `Education` WHERE `name`='Metropolitan State University'), @skillID, 1);

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 1),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 1),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer Intern'), @skillID, 1),
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 1);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Águila de Esperanza website'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Collaborative story-writing web app'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Job search helper web app'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Hinata notes app'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='osmihi.com'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='School counselor caseload dashboard and management tool'), @skillID, 10),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Document revision tracking and management solution'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Checklist document editing and reproduction solution'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ReadID3 Javascript library'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ndvr.co - Portfolio sharing web app'), @skillID, 0);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Programming Languages'), 30, 'HTML');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `EducationSkill` (`educationID`, `skillID`, `seq`) VALUES
  ((SELECT `educationID` FROM `Education` WHERE `name`='Metropolitan State University'), @skillID, 2);

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 2),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 2),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer Intern'), @skillID, 2),
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 2);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Águila de Esperanza website'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Collaborative story-writing web app'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Job search helper web app'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Hinata notes app'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='osmihi.com'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Android RSS Feed Reader / Scraper'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Document revision tracking and management solution'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Checklist document editing and reproduction solution'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ndvr.co - Portfolio sharing web app'), @skillID, 1);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Programming Languages'), 40, 'CSS');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `EducationSkill` (`educationID`, `skillID`, `seq`) VALUES
  ((SELECT `educationID` FROM `Education` WHERE `name`='Metropolitan State University'), @skillID, 3);

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 3),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 3),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer Intern'), @skillID, 3),
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 3);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Águila de Esperanza website'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Collaborative story-writing web app'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Job search helper web app'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Hinata notes app'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='osmihi.com'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Android RSS Feed Reader / Scraper'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Document revision tracking and management solution'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 10),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Checklist document editing and reproduction solution'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ndvr.co - Portfolio sharing web app'), @skillID, 2);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Programming Languages'), 50, 'PHP');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 4);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Águila de Esperanza website'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Collaborative story-writing web app'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Job search helper web app'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Hinata notes app'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='osmihi.com'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 3);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Programming Languages'), 60, 'SQL');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `EducationSkill` (`educationID`, `skillID`, `seq`) VALUES
  ((SELECT `educationID` FROM `Education` WHERE `name`='Metropolitan State University'), @skillID, 4);

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 4),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 4),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer Intern'), @skillID, 4),
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 5);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Águila de Esperanza website'), @skillID, 4),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Collaborative story-writing web app'), @skillID, 4),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Job search helper web app'), @skillID, 4),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Hinata notes app'), @skillID, 4),
  ((SELECT `projectID` FROM `Project` WHERE `name`='osmihi.com'), @skillID, 4),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Analysis for enhancements, bugs, and maintenance of enterprise web app'), @skillID, 15),
  ((SELECT `projectID` FROM `Project` WHERE `name`='School counselor caseload dashboard and management tool'), @skillID, 11),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 4),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Document revision tracking and management solution'), @skillID, 4),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 4),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 11),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 4),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Checklist document editing and reproduction solution'), @skillID, 4),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 4),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 4);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Programming Languages'), 70, 'XML');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 5),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 5),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer Intern'), @skillID, 5);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Android RSS Feed Reader / Scraper'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Analysis for enhancements, bugs, and maintenance of enterprise web app'), @skillID, 16),
  ((SELECT `projectID` FROM `Project` WHERE `name`='School counselor caseload dashboard and management tool'), @skillID, 12),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 5),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Document revision tracking and management solution'), @skillID, 5),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 12),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Checklist document editing and reproduction solution'), @skillID, 5),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 5);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Programming Languages'), 80, 'XSLT');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 6),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 6),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer Intern'), @skillID, 6);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 6),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Document revision tracking and management solution'), @skillID, 6),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 13),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Checklist document editing and reproduction solution'), @skillID, 6),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 6);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Programming Languages'), 90, 'Windows shell scripting');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 6);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='ID3 tagger for radio network'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Radio traffic audit system'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Automated podcast publishing/archive system'), @skillID, 0);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Web Technologies'), 100, 'jQuery');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `EducationSkill` (`educationID`, `skillID`, `seq`) VALUES
  ((SELECT `educationID` FROM `Education` WHERE `name`='Metropolitan State University'), @skillID, 5);

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 7),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 7),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer Intern'), @skillID, 7),
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 7);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Águila de Esperanza website'), @skillID, 5),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Collaborative story-writing web app'), @skillID, 5),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Job search helper web app'), @skillID, 5),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Hinata notes app'), @skillID, 5),
  ((SELECT `projectID` FROM `Project` WHERE `name`='osmihi.com'), @skillID, 5),
  ((SELECT `projectID` FROM `Project` WHERE `name`='School counselor caseload dashboard and management tool'), @skillID, 13),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 7),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Document revision tracking and management solution'), @skillID, 7),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 5),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 14),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 5),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Checklist document editing and reproduction solution'), @skillID, 7),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 5),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 7);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Web Technologies'), 110, 'AngularJS');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 8),
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 8);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 8),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 6),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 8),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ndvr.co - Portfolio sharing web app'), @skillID, 3);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Web Technologies'), 114, 'Underscore');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 9),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 9),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ndvr.co - Portfolio sharing web app'), @skillID, 4);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Web Technologies'), 120, 'Sass');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 9);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 10),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 10);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Web Technologies'), 130, 'JSON');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 10),
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 9);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 11),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 6),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 15),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 6),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ReadID3 Javascript library'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 7),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 11),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ndvr.co - Portfolio sharing web app'), @skillID, 5);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Web Technologies'), 140, 'RESTful APIs');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `EducationSkill` (`educationID`, `skillID`, `seq`) VALUES
  ((SELECT `educationID` FROM `Education` WHERE `name`='Metropolitan State University'), @skillID, 6);

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 10);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 7),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 16),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 7),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 8),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 12);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Web Technologies'), 150, 'MySQL');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `EducationSkill` (`educationID`, `skillID`, `seq`) VALUES
  ((SELECT `educationID` FROM `Education` WHERE `name`='Metropolitan State University'), @skillID, 7);

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 11);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Águila de Esperanza website'), @skillID, 6),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Collaborative story-writing web app'), @skillID, 6),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Job search helper web app'), @skillID, 6),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Hinata notes app'), @skillID, 6),
  ((SELECT `projectID` FROM `Project` WHERE `name`='osmihi.com'), @skillID, 6),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 8),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 8),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 9);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Web Technologies'), 160, 'Microsoft SQL Server');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `EducationSkill` (`educationID`, `skillID`, `seq`) VALUES
  ((SELECT `educationID` FROM `Education` WHERE `name`='Metropolitan State University'), @skillID, 8);

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 11),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 8),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer Intern'), @skillID, 8);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Analysis for enhancements, bugs, and maintenance of enterprise web app'), @skillID, 17),
  ((SELECT `projectID` FROM `Project` WHERE `name`='School counselor caseload dashboard and management tool'), @skillID, 14),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 12),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Document revision tracking and management solution'), @skillID, 8),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Checklist document editing and reproduction solution'), @skillID, 8),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 13);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Web Technologies'), 170, 'Twitter Bootstrap');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 12),
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 12);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 13),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 9),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 10),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 14),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ndvr.co - Portfolio sharing web app'), @skillID, 6);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Web Technologies'), 174, 'RequireJS');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 14),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 15);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Design'), 180, 'Object-oriented design');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `EducationSkill` (`educationID`, `skillID`, `seq`) VALUES
  ((SELECT `educationID` FROM `Education` WHERE `name`='Metropolitan State University'), @skillID, 9);

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 13),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 9),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer Intern'), @skillID, 9),
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 13);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Android RSS Feed Reader / Scraper'), @skillID, 4),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Analysis for enhancements, bugs, and maintenance of enterprise web app'), @skillID, 14),
  ((SELECT `projectID` FROM `Project` WHERE `name`='8-bit RPG Battle Game'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Operating Systems synchronization project'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 15),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Document revision tracking and management solution'), @skillID, 9),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 9),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 17),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 10),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Checklist document editing and reproduction solution'), @skillID, 9),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 11),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 16);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Design'), 190, 'Relational Database Schema design');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `EducationSkill` (`educationID`, `skillID`, `seq`) VALUES
  ((SELECT `educationID` FROM `Education` WHERE `name`='Metropolitan State University'), @skillID, 10);

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 14),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 10),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer Intern'), @skillID, 10),
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 14);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Águila de Esperanza website'), @skillID, 7),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Collaborative story-writing web app'), @skillID, 7),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Job search helper web app'), @skillID, 7),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Hinata notes app'), @skillID, 7),
  ((SELECT `projectID` FROM `Project` WHERE `name`='osmihi.com'), @skillID, 7),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Analysis for enhancements, bugs, and maintenance of enterprise web app'), @skillID, 13),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 16),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Document revision tracking and management solution'), @skillID, 10),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 10),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 18),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 11),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Checklist document editing and reproduction solution'), @skillID, 10),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 12),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 17),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ndvr.co - Portfolio sharing web app'), @skillID, 7);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Design'), 200, 'Requirements Analysis');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `EducationSkill` (`educationID`, `skillID`, `seq`) VALUES
  ((SELECT `educationID` FROM `Education` WHERE `name`='Metropolitan State University'), @skillID, 11);

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 15),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 11),
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 15);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Águila de Esperanza website'), @skillID, 8),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Collaborative story-writing web app'), @skillID, 8),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Job search helper web app'), @skillID, 8),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Hinata notes app'), @skillID, 8),
  ((SELECT `projectID` FROM `Project` WHERE `name`='osmihi.com'), @skillID, 8),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Analysis for enhancements, bugs, and maintenance of enterprise web app'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='8-bit RPG Battle Game'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='School counselor caseload dashboard and management tool'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 17),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Document revision tracking and management solution'), @skillID, 11),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 11),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 12),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meeting scheduler'), @skillID, 0),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Checklist document editing and reproduction solution'), @skillID, 11),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 13),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 18),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ndvr.co - Portfolio sharing web app'), @skillID, 8);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Design'), 210, 'UI/UX design');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 16),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 12),
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 16);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Águila de Esperanza website'), @skillID, 9),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Collaborative story-writing web app'), @skillID, 9),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Job search helper web app'), @skillID, 9),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Hinata notes app'), @skillID, 9),
  ((SELECT `projectID` FROM `Project` WHERE `name`='osmihi.com'), @skillID, 9),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Analysis for enhancements, bugs, and maintenance of enterprise web app'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='8-bit RPG Battle Game'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='School counselor caseload dashboard and management tool'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Operating Systems synchronization project'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 18),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Document revision tracking and management solution'), @skillID, 12),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 12),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 13),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meeting scheduler'), @skillID, 1),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Checklist document editing and reproduction solution'), @skillID, 12),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 14),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 19),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ndvr.co - Portfolio sharing web app'), @skillID, 9);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Design'), 215, 'Wireframes');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Analysis for enhancements, bugs, and maintenance of enterprise web app'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='School counselor caseload dashboard and management tool'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 19),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 13),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 6);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Design'), 220, 'APIs');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `EducationSkill` (`educationID`, `skillID`, `seq`) VALUES
  ((SELECT `educationID` FROM `Education` WHERE `name`='Metropolitan State University'), @skillID, 12);

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 17),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 13),
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 17);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Android RSS Feed Reader / Scraper'), @skillID, 5),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Analysis for enhancements, bugs, and maintenance of enterprise web app'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='School counselor caseload dashboard and management tool'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 20),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Document revision tracking and management solution'), @skillID, 13),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 14),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 14),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Checklist document editing and reproduction solution'), @skillID, 13),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 15),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 20);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Software'), 230, 'Eclipse');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `EducationSkill` (`educationID`, `skillID`, `seq`) VALUES
  ((SELECT `educationID` FROM `Education` WHERE `name`='Metropolitan State University'), @skillID, 13);

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 18),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 14),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer Intern'), @skillID, 11),
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 18);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Águila de Esperanza website'), @skillID, 10),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Android RSS Feed Reader / Scraper'), @skillID, 6),
  ((SELECT `projectID` FROM `Project` WHERE `name`='8-bit RPG Battle Game'), @skillID, 4),
  ((SELECT `projectID` FROM `Project` WHERE `name`='School counselor caseload dashboard and management tool'), @skillID, 4),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Operating Systems synchronization project'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 21),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Document revision tracking and management solution'), @skillID, 14),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 15),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 15),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 16),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 21);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Software'), 240, 'IntelliJ');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 19),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 15),
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 19);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 22),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Checklist document editing and reproduction solution'), @skillID, 14),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 17),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 22),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ndvr.co - Portfolio sharing web app'), @skillID, 10);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Software'), 250, 'Git');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `EducationSkill` (`educationID`, `skillID`, `seq`) VALUES
  ((SELECT `educationID` FROM `Education` WHERE `name`='Metropolitan State University'), @skillID, 14);

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 20),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 16),
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 20);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Águila de Esperanza website'), @skillID, 11),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Android RSS Feed Reader / Scraper'), @skillID, 7),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Analysis for enhancements, bugs, and maintenance of enterprise web app'), @skillID, 4),
  ((SELECT `projectID` FROM `Project` WHERE `name`='8-bit RPG Battle Game'), @skillID, 5),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Operating Systems synchronization project'), @skillID, 4),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 23),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 16),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 2),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 16),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Checklist document editing and reproduction solution'), @skillID, 15),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ReadID3 Javascript library'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 18),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 23),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ndvr.co - Portfolio sharing web app'), @skillID, 11);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Software'), 260, 'Subversion');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 21),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 17),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer Intern'), @skillID, 12);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Analysis for enhancements, bugs, and maintenance of enterprise web app'), @skillID, 5),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 24),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Document revision tracking and management solution'), @skillID, 15);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Software'), 270, 'Apache');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `EducationSkill` (`educationID`, `skillID`, `seq`) VALUES
  ((SELECT `educationID` FROM `Education` WHERE `name`='Metropolitan State University'), @skillID, 15);

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 21);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Águila de Esperanza website'), @skillID, 12),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Collaborative story-writing web app'), @skillID, 10),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Job search helper web app'), @skillID, 10),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Hinata notes app'), @skillID, 10),
  ((SELECT `projectID` FROM `Project` WHERE `name`='osmihi.com'), @skillID, 10),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 17),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 17),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 19),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ndvr.co - Portfolio sharing web app'), @skillID, 12);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Software'), 280, 'Microsoft Office');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 18),
  ((SELECT `workID` FROM `Work` WHERE `name`='Hinata LLC' AND `title` = 'Web Developer, Managing Member'), @skillID, 22);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Águila de Esperanza website'), @skillID, 13),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Collaborative story-writing web app'), @skillID, 11),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Job search helper web app'), @skillID, 11),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Hinata notes app'), @skillID, 11),
  ((SELECT `projectID` FROM `Project` WHERE `name`='osmihi.com'), @skillID, 11),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Analysis for enhancements, bugs, and maintenance of enterprise web app'), @skillID, 6),
  ((SELECT `projectID` FROM `Project` WHERE `name`='School counselor caseload dashboard and management tool'), @skillID, 5),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 18),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ChrisAndOthman.com'), @skillID, 18),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meeting scheduler'), @skillID, 2);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Software'), 290, 'Visio');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `EducationSkill` (`educationID`, `skillID`, `seq`) VALUES
  ((SELECT `educationID` FROM `Education` WHERE `name`='Metropolitan State University'), @skillID, 16);

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 19);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Analysis for enhancements, bugs, and maintenance of enterprise web app'), @skillID, 7),
  ((SELECT `projectID` FROM `Project` WHERE `name`='OrdrUpApp.com'), @skillID, 19),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meeting scheduler'), @skillID, 3),
  ((SELECT `projectID` FROM `Project` WHERE `name`='djCalculator.com'), @skillID, 20),
  ((SELECT `projectID` FROM `Project` WHERE `name`='ndvr.co - Portfolio sharing web app'), @skillID, 13);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Software'), 300, 'JIRA');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 22),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 20),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer Intern'), @skillID, 13);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Analysis for enhancements, bugs, and maintenance of enterprise web app'), @skillID, 8),
  ((SELECT `projectID` FROM `Project` WHERE `name`='School counselor caseload dashboard and management tool'), @skillID, 6),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 25),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Document revision tracking and management solution'), @skillID, 16),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 4),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Checklist document editing and reproduction solution'), @skillID, 16),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 24);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Software'), 310, 'Wiki (Confluence)');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer'), @skillID, 23),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 21),
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Engineer Intern'), @skillID, 14);

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Analysis for enhancements, bugs, and maintenance of enterprise web app'), @skillID, 9),
  ((SELECT `projectID` FROM `Project` WHERE `name`='School counselor caseload dashboard and management tool'), @skillID, 7),
  ((SELECT `projectID` FROM `Project` WHERE `name`='General development of enterprise web app'), @skillID, 26),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Document revision tracking and management solution'), @skillID, 17),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 5),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meeting scheduler'), @skillID, 4),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Checklist document editing and reproduction solution'), @skillID, 17),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Learner Planning Document Editor Application'), @skillID, 25);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Software'), 315, 'Gliffy');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Analysis for enhancements, bugs, and maintenance of enterprise web app'), @skillID, 10),
  ((SELECT `projectID` FROM `Project` WHERE `name`='School counselor caseload dashboard and management tool'), @skillID, 8),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 7),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meeting scheduler'), @skillID, 5);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Software'), 320, 'Balsamiq');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Analysis for enhancements, bugs, and maintenance of enterprise web app'), @skillID, 11),
  ((SELECT `projectID` FROM `Project` WHERE `name`='School counselor caseload dashboard and management tool'), @skillID, 9),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 8);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Software'), 320, 'GIMP (Photoshop)');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `ProjectSkill` (`projectID`, `skillID`, `seq`) VALUES
  ((SELECT `projectID` FROM `Project` WHERE `name`='Águila de Esperanza website'), @skillID, 14),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Collaborative story-writing web app'), @skillID, 12),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Job search helper web app'), @skillID, 12),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Hinata notes app'), @skillID, 12),
  ((SELECT `projectID` FROM `Project` WHERE `name`='osmihi.com'), @skillID, 12),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Analysis for enhancements, bugs, and maintenance of enterprise web app'), @skillID, 12),
  ((SELECT `projectID` FROM `Project` WHERE `name`='8-bit RPG Battle Game'), @skillID, 6),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meetings management integrated web application'), @skillID, 9),
  ((SELECT `projectID` FROM `Project` WHERE `name`='Meeting scheduler'), @skillID, 6);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Accolades'), 320, 'At request of C-level executive, reprised a stakeholder presentation to be recorded as an example for others');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 22);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Leadership'), 330, 'Architected and led a team of developers to rapidly develop a fully functional web / mobile application');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `EducationSkill` (`educationID`, `skillID`, `seq`) VALUES
  ((SELECT `educationID` FROM `Education` WHERE `name`='Metropolitan State University'), @skillID, 17);

INSERT INTO `Skill` (`portfolioID`, `skillCategoryID`, `seq`, `name`) VALUES
  (@portfolioID, (SELECT `skillCategoryID` FROM `SkillCategory` WHERE `name`='Credentials'), 340, 'Obtained a Certificate of Business Analysis from the University of Minnesota in 2013; member IIBA MSP');
SET @skillID = LAST_INSERT_ID();

INSERT INTO `WorkSkill` (`workID`, `skillID`, `seq`) VALUES
  ((SELECT `workID` FROM `Work` WHERE `name`='Infinite Campus' AND `title` = 'Software Product Analyst - Technical'), @skillID, 23);
