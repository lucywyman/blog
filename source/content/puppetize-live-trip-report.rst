Puppetize Live 2018
===================
:date: 10-14-2018
:tags: conferences, tech, experiences
:category: Tech
:slug: puppetize-live-2018
:author: Lucy Wyman
:image:

I'm writing this on the plane home from Amsterdam after an exciting,
challenging, educational, and ultimately successful week. For those
that don't know `Puppet`_ conducted `a grand experiment`_ this year:
instead of hosting a multi-day, multi-track conference (nee
Puppetconf), our annual celebration was a single-track, live streamed
event that ran for 22 hours across 3 cities. A lot of people had a lot
of feelings about it, so I'll stick to speaking for myself and my
experiences in this post.

.. _Puppet: https://puppet.com
.. _a grand experiment: https://puppet.com/blog/puppetize-live-cfp

When I first heard about the new format I was genuinely excited. I
attend a lot of conferences of varying quality and formats, and I
appreciated how Puppet was trying to 1. Increase community involvement
and the accessibility of PuppetConf, 2. Reach out on a global scale
rather than happen just in the US, and 3. Focus more on content and
less on the 'party'. Each of these goals aligned strongly with my
personal values and those of the company, and I had never heard of a
conference trying this format so was interested to see how it would
go. It was and is a great idea.

We got a lot of negative feedback throughout the conference process,
from when we announced it through the conference itself. I don't want
to harp on it here - we've talked about it enough internally and I'd
only be spiralling in the same eddies of negativity. I was surprised
and disappointed in the Puppet community, and while I heard only
1/10th of the abuse our organizers got it changed my expectations
going into the event for the worse, and made me equal parts defensive
/ wary / pressured / upset.

I was lucky enough to be sent to AMSTERDAM to talk about `Bolt`_, the
project I work on, and even luckier to be going with some really
fantastic coworkers.

.. _Bolt: https://github.com/puppetlabs/bolt

A quick aside, while we're talking about coworkers. International
travel is stressful. Running a conference, especially an experimental
one, is stressful. Doing both of these at the same time is borderline
insane. The people I work with didn't just put on a fantastic event,
they did so with compassion, humanity, empathy, and selflessness.
They were calm and kind in the most strenuous, frustrating,
nerve-wracking circumstances. They communicated clearly, were
respectful of everyone involved, and pulled off an international event
with barely a hiccup. But most of all, I really enjoyed getting to
travel with them. It's so rare that you can say you work well with
everyone on your team, let alone that you enjoy spending *18 hours a
day in a foreign country for a week with your team*. I can't believe
how fortunate I am to work with humans who are so nice, understanding,
and friendly, and who I still want to go to dinner with at 8pm after
getting up at 6am and rehearsing together for ~10 hours.

Ok, gushy aside over. I got into Amsterdam on Sunday, and spent most
of Monday and Tuesday rehearsing my `keynote demo`_ and prepping for
my `Bolt talk`_.  Tuesday night was the first 'official' event of
Puppetize, a pre-event meetup at a cute nearby pub. There were maybe 3
or 4 dozen people there, a mix of Puppet customers, open source Puppet
users, and Puppet employees. Maybe it was because I was so jet lagged
still, maybe it was because of the aforementioned animosity towards
the new event, maybe it was cultural differences, or maybe it was just
my imagination, but it felt like a lot of the people I talked to were
weirdly....skeptical? I couldn't tell if they didn't think I was
technical (no surprise there weren't a ton of female engineers...), if
they weren't sure what the event was about, or if these things are
just more awkward than I remembered.  Thinking back to the Puppet
Contributor Summit last year, it felt like everyone I talked to
*loved* Puppet, and was really excited about the work we were doing -
or at least interested in our new tools.  For whatever reason, this
event felt more like people were asking "Prove to me that this was
worth my time". It wasn't all bad, I had some interesting
conversations, but it was less good than in previous years.

.. _keynote demo: https://youtu.be/YpbhaRRBv-Y
.. _Bolt talk: https://youtu.be/HfXkD9GAVxY

The next morning we got up bright and early, and arrived at the venue
before any of the coffee shops had even opened. We all paced around
nervously while A/V set up, and then we got to *have our makeup done*.
Yeah! Puppet hired a makeup artist to make sure we didn't look shiny
on camera, and she was nice enough to do a full face of makeup for me.
I've never had my makeup done before, and it was an entirely new and
mostly pleasant experience. I felt so nervous that she would do
something I didn't like - you should have seen my face when she pulled
out a curling iron - but of course she did a great job and it ended up
being really fun and feeling very luxurious to have someone do my
makeup.

Then it was time to go! We all watched the keynotes progress
backstage, going out in turn as it was our turn. My role was to run 2
out of 4 product demos, first of Bolt (the easy one, obviously) then
of `Continuous Delivery for Puppet Enterprise (CD4PE)`_. I thought the
demos went well, specifically because we had been rehearsing so much
in the last few days. I hit all my talking points, I sounded confident
and knowledgeable, and I felt I showed both tools in their best light.

After the keynotes we got to mingle with attendees for a bit, which is
always the best part of conferences. People were excited about Bolt,
which was exciting for us, and there was a good mix of easy-to-answer
technical questions and interesting-to-consider questions about where
we would take the project from here. I had never heard of `Choria`_
before, but we fielded a lot of questions about it's compatibility,
as well as how Bolt could replace some of `MCollective's`_
functionality. A lot of folks I talked to were on old versions of
Puppet (3.8 or earlier), and while they were trying to upgrade there
were a lot of challenges, MCO's deprecation being one of many. The
other topic we heard a lot about was credential management, and
developing workflows for authenticating bolt with different parts of
their infrastructure.

Next up was talks, and mine was last in the morning set. I'll be
honest, I didn't really hear much of the other 2 talks since I was
buzzing with so much nervousness and excitement about my own talk.
While I'm a practiced public speaker, this talk felt like it had
higher stakes than many of my other talks: rather than being for a
bunch of strangers, I knew many of my coworkers and friends would
likely watch this talk, and that it could really impact the success of
our project. I wasn't nervous that my talk wouldn't go well, but that
it wouldn't be well received or that if it *didn't* go well it could
have real consequences.

But once I took the stage, I was in my comfort zone. Bolt is the
easiest topic in the world to talk about since it's the thing I spend
most of my waking hours thinking about. I wish I had polished my demo
more, and used VMs instead of a canned demo (for obvious reasons, if
you watch). But demo flubs are nothing new in tech talks, and I
thought overall that I showed Bolt off well. I crammed a lot of
features into not a lot of time, and while others on my team could
probably have done a better job I felt I had done the best I could
(again, demo aside). 

After talks, there was lunch and more mingling with users. Now more
people had more easy-technical questions about bolt, and it was
exciting to hear some folks had already downloaded and started playing
with it. One of my favorite things about the project is how easy it is
to understand, explain, and get started with, which makes those first
user experiences fun rather than frustrating. A member from my team,
Nick, was fielding questions as well, and after the adrenaline of both
talks that morning and lingering jet lag I felt pretty zoned out by
the end of lunch. I took a walk and a long lunch, and made sure to be
back in time for `Paula and Helen's`_ talk that afternoon.

Though I'd already seen a practice version, I really enjoyed their
talk. It was funny and informative, and focused on making life easier
for our community and contributors. As always, I'm a sucker for an
open source software talk, and thought they did a great job! I'm
reasonably certain it was their first time speaking, too, and you'd
never know it from their performance.

I left to hang out at the Puppet booth a bit and answer questions
about Puppet during the last talk. Then was our after-hours event,
Puppet Connect. I think there was supposed to be a community aspect to
this event, similar to a mini-contributor-summit, but it ended up
falling a bit flat. In the end I just spent more time talking to
users, some of whom were familiar faces by now, and then we headed out
to a celebratory dinner. With that, the curtain had closed on
Puppetize Live 2018!

The Good
--------

We had a lot of positive feedback about the event during it. I heard
so many times that folks would never be able to go to San Francisco
for a week for PuppetConf, but could easily travel anywhere in Europe
for a day or 2. After so much negativity, this feedback made my heart
sing since that was the whole point! I was so glad that people who
would not have otherwise been able to participate were able to come.

The positive side of the live stream is that everything was published
online pretty shortly after airing. It was great to be able to refer
folks to talks that had happened in other timezones, and know that it
would only take 25 minutes of their time to get caught up on a topic
or tool.

The Bad
-------

Puppetize Live felt a lot smaller than PuppetConf, and while I didn't
necessarily miss the 'party' aspect of PuppetConf I did miss the
feeling of a large Puppet community coming together and celebrating.
This felt more like a glorified meetup than a conference, and while
a more intimate event was great in some ways it overall made the
experience feel more empty. I didn't feel the same sense of awe at how
our software was impacting the world, but felt more like I was trying
to convince people it was worth their time. 

Similarly, the Puppet open source community felt much smaller and like
a 'side event'. The contributor summit last year felt big and
important, and made the community feel vibrant. Puppet connect was by
comparison tiny, insignificant, and dominated by long standing
community members (so it didn't feel like there was really room for me
at the table, literally and figuratively), and felt like an
afterthought. This also made the open-source and community aspects of
Puppet feel understated, and I wished we had more emphasis on what our
users were doing with Puppet than the new products.

Lastly, I was disappointed with the live-stream and slack participation.
It seemed like not many folks watched, and even fewer commented in
channel. Those who did comment would comment on what they didn't like
about talks, rather than asking questions or talking about the
technology. It brought out people's troll-iest behavior, which was
disheartening.

Overall 
-------

I'm proud of the event we held and of my role in it, and
disappointed that it felt like that didn't resonate with our
community. I had a lot of fun, and feel a renewed connection to
working for Puppet as a company and working on Bolt as a project. I
love my job, and felt a renewed sense of purpose after Puppetize. But
I also felt disheartened by the lack of enthusiasm from others, and
hope that as an organization we can find new ways to get people pumped
about our software.

.. _Continuous Delivery for Puppet Enterprise (CD4PE): https://puppet.com/blog/continuous-delivery-puppet-enterprise-simplifies-code-tracking-test-results
.. _Choria: https://choria.io/
.. _MCollective's: https://puppet.com/docs/mcollective/current/index.html
.. _Paula and Helen's: https://youtu.be/qMNR2KQz7Kg
