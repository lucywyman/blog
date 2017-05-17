OSCON 2017
==========
:date: 2017-05-15
:tags: experiences, conferences, tech
:category: Conferences
:slug: oscon-2017
:author: Lucy Wyman
:img: 

Highlights
----------

There's a *ton* of content in this post, including a lot of links to
even more content.  Here's the good stuff, if you want to skip the
gory details.

* `Step 1: Punch a Tree`_ by Evan Booth
* `Choose Open Infrastructure`_ by Christopher Aedo
* `Finding your way in the dark: Security from first principles`_ by Susan Sons
* `Stephen King's practical advice for tech writers`_ by Rikki Endsley
* `The frontend dev's illustrated Rust adventure survival guide`_ by Liz Baillie

FAQ
---

**How was OSCON?**
Overall, this was an excellent conference! I'm not sure if the quality
of speakers was especially high this year or if I'm just getting
better at choosing which talks to attend, but I was *very* impressed
with the speakers and their topics. There were only 1 or 2
talks that weren't useful to me, and even then I didn't find myself
wishing I had attended a different talk. I learned a lot, got to catch
up with OSS nerd friends, and got to meet some fantastic folks!

**How did your talk go?**
Very well! As the speaker it always feels like there are a million
little things you should have done differently (I should have
introduced this topic sooner, I should have defined this phrase, I
should have put my contact info *somewhere* in the slides, etc.). But
attendees were engaged and attentive throughout the presentation, lots
of people asked good questions, and those that I spoke to said they
had clear takeaways from the presentation. Could it have been better?
Definitely. Was it helpful to those who attended? Definitely. Looking
back I consider it a success.

**How did you like Austin?**
Visiting Austin was also fun. As one of those people who is always
cold I love visiting warmer climates, even if it's overcast and muggy.
There was an abundance of good food (I'll take 3 fried avocado tacos
please thank you), cute parks and urban hiking, and fantastic street
art. There was also live music *at the airport*. I was also visiting
with a friend who had already been in Austin for 2 weeks (for
`DreamHack`_), and later with a friend who lives in Austin, both of
whom were tremendously helpful in navigating the city and it's many
attractions. Would I visit again for a vacation? Probably not at the
top of my list. But if OSCON *had* to be somewhere other than
Portland, I definitely didn't mind it being in Austin.

.. _DreamHack: https://austin.dreamhack.com/

OK, on to the session I attended throughout the conference!

Wednesday
---------

Keynotes
~~~~~~~~

`Step 1: Punch a Tree`_
+++++++++++++++++++++++

This was one of the most polished, entertaining, and well done talks
I've seen in a while. It packed a punch, and was put together without
being over the top. The "slides" were amazing (I had never seen slides
like that before, or even thought to do something similar), the videos
and sound effects were appropriate, well timed, and placed well
(again, without being over the top), and the message was a truly open
source and resonant one. Evan spoke about hardware hacking, and
advocated for general parts to be standardized and made
interchangeable like how batteries are now. For example, why can't we
have motors be widely available and easy to replace in everything from
toys to microwaves to blenders? An excellent and inspiring note to start on!

`Choose Open Infrastructure`_
+++++++++++++++++++++++++++++
By Christopher Aedo

Another excellent keynote! Chris works for IBM, which at a conference
like OSCON tends to make the audience skeptical. Chris' talk was
anything but a product pitch though -- he spoke about how we can make
infrastructure (read: compute storage and networking) more open across
the industry. He spoke about the business benefits of using open
source, how to build or choose infra tools using 3 open source
principles, and listed common tools that met all 3 of those
principles. There was no mention of IBM, or even any projects or
products they were working on, just some hard core pro-open source
talk. 

3 Open Source Principles:

* **Transparency** - do they work openly?
* **Interoperability** - can I get my data off the platform? Or am I locked in?
* **Influence** - do they listen to non-paying users?

.. _Choose Open Infrastructure: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/61296

`Open source contribution and collaboration: How (and why) Netflix drives industry engagement`_
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
By Dianne Marsh

In this talk, Dianne used Netflix project `Spinnaker`_ as a case study
for how to successfully collaborate with other companies, in the
context of open source. It was an interesting an insightful talk,
and made me hopeful that companies like Netflix will continue to do
open source right. Dianne also made some good points about how
to successfully collaborate (in this case across companies), notably:

* Build trust
* Learn to communicate effectively (whatever that means for your
  specific team + companies)
* Value input from everyone
* Don't lose sight of your objective

While this is pretty standard advice, I *do* think that a project is
less likely to succeed without these. Overall, interesting but not
mind blowing.

.. _Open source contribution and collaboration\: How (and why) Netflix drives industry engagement: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/59265
.. _Spinnaker: http://www.spinnaker.io/

`The power of the open source ecosystem`_
+++++++++++++++++++++++++++++++++++++++++
By Ying Xiong 

It was awesome to see a non-US speaker on stage, and I definitely hope
to see more non-US based technologies, companies, and individuals
speaking at OSCON in the future! That said, I think this talk in
particular missed the mark. It was Huawei paying lip service to open
source with misspelled slides and no clear point besides an
unconvincing "Huawei supports open source".

.. _The power of the open source ecosystem: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/61737

`Rebuilding trust through blockchains and open source`_
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
By Brian Behlendorf

I think `block chains`_ are super cool, but this was a weird
keynote. Maybe that's only because I'm not used to business-y
keynotes, but this was 5 minute talk that included the phrase "This is
as exciting as when the internet was starting" and a plea to come to a
talk later that day. Mad respect to Brian, but I think this felt out
of place and insincere.

.. _Rebuilding trust through blockchains and open source: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/60576
.. _block chains: https://en.wikipedia.org/wiki/Blockchain

`Sharing America's code`_
+++++++++++++++++++++++++
By Alvand Salehi

Imagine a very corny Don Draper giving this talk. Alvand is a
physically beautiful human who is, like, 5 years away from being a
really great speaker. But right now he is completely Over the Top. My
favorite quote from this talk was:

'And then, they did something *even bolder*: they open sourced their
project. It gives me chills just thinking about it'

The content of the talk was super interesting though. Alvand works for
the US government, and talked about `code.gov`_, the `Source Code
Policy`_, and other efforts within the government to promote open
source and deduplicate software usage throughout the government. He
talked specifically about `anet`_, a little tool to track which NATO
advisors have trained which Afghan officials, and spoke about the team
which led that project and what helped them succeed. It was honestly a
really good keynote, despite (or maybe including) the speaker's
hilarious exaggerations and style. 

.. _Sharing America's code: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/59364
.. _code.gov: https://code.gov
.. _Source Code Policy: https://sourcecode.cio.gov/
.. _anet: https://github.com/deptofdefense/anet

`My Talk!`_
~~~~~~~~~~~

First session Wednesday morning was my talk! First, I have to say that
I was bizarrely calm before giving my talk. The kind of nerves I get
are usually a very physical kind, where for the full hour before my talk
starts I'll have butterflies in my stomach, and sweaty palms, and
short breath. But this time none of that happened. *shrug*. Maybe my
body is catching on that public speaking isn't scary? But about the
talk! It's so hard to have perspective about talks you give, and so my
initial reaction when people asked how it went was to say "Oh, there
were so many things I could have improved or done better". For
example, I completely neglected to include any contact information or the link
to my slides in my presentation. But everyone I spoke to after the
talk, even those who had constructive feedback, told me that they had
really enjoyed the talk and had gotten something out of it. Overall
I'm reasonably pleased with how it went, have a list of notes to
myself for future versions of this talk, and sincerely hope that I was
able to make contributing to open source software a little less
intimidating for someone. 

.. _My Talk: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/56686

`Finding your way in the dark: Security from first principles`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
By Susan Sons

How do you secure the equipment used to measure water movement below
ice floes? Or equipment taking measurements in a volcano? At the
`National Science Foundation`_, these are the kind of questions Susan
Sons is asked. This talk was really great for a few reasons:
1. It presented general lessons that anyone in the room could use
2. It also provided specific examples to illustrate how to apply those lessons. 
3. It supported it's claims
4. Susan told interesting stories, and was clearly an incredibly competent and knowledgeable human. 

None of this is to say that talks without the above are bad, but I
think these things were at least part of what made Susan's talk an
incredibly successful one. I walked away with a new set of tools that
I could apply to my job (and likely future jobs), a full understanding
of how to use those tools, and more knowledge about `Thermopylae`_!

Susan talked about 7 principles that help guide and support decisions
about how to secure a wide variety of systems:

1. **Comprehensivity** - Am I covering all my bases?
2. **Opportunity** - Am I taking advantage of my resources?
3. **Rigor** - What is correct behavior, how am I ensuring it?
4. **Minimization** - Can this be smaller?
5. **Compartmentalization** - Is this made of distinct parts with
   limited interactions?
6. **Fault Tolerance** - What happens if this fails?
7. **Proportionality** - Is it worth it?

After introducing the principles, the rest of the talk used examples
to color in details on how to apply the principles and justify their
place in the list. If you have the time and are interested in
security, I highly highly recommend watching!

.. _Finding your way in the dark\: Security from first principles: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/57236
.. _National science Foundation: https://www.nsf.gov/
.. _Thermopylae: https://en.wikipedia.org/wiki/Battle_of_Thermopylae

`Enhancing cloud security with the TPM`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
By James Bottomley

Another excellent talk! James talks at a mile a minute, though I was
lucky to know juuust enough background knowledge to be able to keep
up. `The TPM`_ is a small chip that's used to securely generate,
store, and limit use of cryptographic keys. James talk was
about using the TPM to store cloud machine's secrets, specifically VPN keys and
potentially RSA keys. There are a number of stumbling blocks towards
this goal, not the least of which is a radical difference in how the
TPM 1.2 and TPM 2.0 work (which makes backwards compatibility
difficult at best and impossible at worst). I had never heard of the
TPM before this talk, and while I can't say I fully grok how it might
be used in the future it certainly seems worth knowing more about and
keeping an eye on, in the context of security in the cloud! Definitely
worth a watch if you are mathematically or security inclined.

.. _Enhancing cloud security with the TPM: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/57075
.. _The TPM: https://en.wikipedia.org/wiki/Trusted_Platform_Module

`Stephen King's practical advice for tech writers`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
By Rikki Endsley

I'll start by saying I adore Rikki. I've only met her a few times, but
she's always lovely, welcoming, and easy to talk to. She spoke about
tips for writing, most of which are relatively common knowledge but as
an occasional writer I found them both inspiring and helpful! It never
hurts to be reminded of how to structure your articles based on your
audience, have a clear point, and that the only way to get better at
writing is by writing. Rikki also provided a number of tech-industry
specific tips (how technical to be in various articles, for example),
as well as a number of quips from `Stephen King`_ (kill your darlings,
kill your darlings). Although this was a "common knowledge" type
of talk, it's also the talk I got the most out of in the
whole conference, particularly since writing plays such an important
role in my job and life. I was reminded to edit my pieces (woops,
don't usually do that!), to learn to handle criticism, and to know who
I'm writing for. Overall, a super worthwhile and excellent talk from a
true expert (and open source hero!).

Key Takeaways:

* Before you write know what you are writing about, why you're writing, and who your reader is
* Research, outline, write, revise
* 3 categories of audience in tech: lay audience, managers, experts
* Good writing requires lots of reading and writing
* Have clear expectations for what your piece needs to deliver
* Invite the reader in
* Tell a story
* Leave out the boring parts
* Include lists
* To write is human, to edit is divine
* Kill your darlings
* Find a brutally honest editor
* Start writing!

.. _Stephen King's practical advice for tech writers: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/55872
.. _Stephen King: https://www.goodreads.com/work/quotes/150292-on-writing-a-memoir-of-the-craft

`How I learned to stop being afraid and love the JVM`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
By James Turnbull

Ok, if you're reading this post straight through, I know at this point
it might seem like I loved *all* of the talks I went to at OSCON,
which makes loving a talk feel cheap. Let me assure you that 1. This
is an anomaly, and 2. There will be less great reviews later on! I
think this a combination of OSCON attracting particularly stellar
speakers this year, as well as my own increased skill in finding which
talks I want to go to and can get the most out of. Or maybe I'm just
really happy as I'm writing this because I'm heading home and get to
see my boyfriend in an hour. Who knows. But I digress.

James' talk about how the `JVM`_ has improved since the mid-2000s was
also excellent. As someone who never writes java and only occasionally
interacts with the JVM via `clojure`_, I wasn't sure if I would have
enough context to get much out of this talk. But James explained in
great detail the pain points and horror stories of the old JVM that
many grizzled sysadmins will tell you about. His talk set up the
problem, explained how the JVM has improved and how those improvements
have made impacts in the industry. 

Key Takeaways:

* Legacy java is pretty ugly, verbose, and repetitive. And there's *lots* of bad java out there
* JVM has always been generally performant
* JVM doesn't always respond to general fixes (for example, you have to tell it to use more memory, not just throw memory at it)
* JVM needs tuning, not always intuitive
* JVM stacktraces are impossible to read
* Hard to automate the JVM (mentioned Puppet!)
* JVM wasn't transparent
* Android has really helped modern java improve
* JVM is *super* fast
* Logging has improved dramatically
* More transparent now
* Security has become a much higher priority

.. _How I learned to stop being afraid and love the JVM: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/56563
.. _JVM: https://en.wikipedia.org/wiki/Java_virtual_machine
.. _clojure: http://www.braveclojure.com/

`Web application security: Browsers fight back`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
By Christian Wenz

Last talk of the day is a tough slot, but Christian made HTTP headers
both interesting and hilarious. This talk covered the major threats
facing web applications today (namely `XSS`_, `Cookie hijacking`_,
`CSRF`_, and `referrer data leakage`_), and what we as web developers
can actively and easily do to prevent those attacks. Favorite quote was 

"To allow inline javascript, I need to add :code:`script-src unsafe-inline;`. Writing 'unsafe-inline' feels so good."

Key Takeaways:

* `Content Security Policy`_ is a `W3C`_ standard for security related http header content
* https://caniuse.com to look up which security policies are supported by which browsers
* CSP works by having the header and a 'directive', for example :code:`default-src 'self';`

.. _Web application security\: Browsers fight back: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/56864
.. _XSS: https://www.owasp.org/index.php/Cross-site_Scripting_(XSS)
.. _Cookie hijacking: https://www.owasp.org/index.php/Session_hijacking_attack
.. _CSRF: https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF)
.. _referrer data leakage: https://blog.mozilla.org/security/2015/01/21/meta-referrer/
.. _Content Security Policy: https://content-security-policy.com/
.. _W3C: https://www.w3.org/

Thursday
--------

Keynotes
~~~~~~~~

`Ask more questions`_
+++++++++++++++++++++
By Saron Yitbarek

Asking questions is scary. It means you have to admit you don't know
the answer, and puts you in a vulnerable position. But asking
questions is key to creating a successful project, and often the
hardest questions are the most important. Saron was well-spoken, and
while this talk wasn't anything revolutionary it was something we
could all be reminded of regularly, and included some excellent
personal stories. 

.. _Ask more questions: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/59184

`Half my life spent in open source`_
++++++++++++++++++++++++++++++++++++
By Brad Fitzpatrick

This was just a cute telling of Brad's time in open source software,
from learning Perl as a teenager to spending 7 years working on Go.
Included were some wise words:

* Easy != quick
* Everything has maintenance cost
* All code you put online will end up in production

Nothing especially insightful, but a really nice story that I hope a
lot of people in the room could connect to. I love hearing how open
source changes people's lives, and this was an excellent open source
love story well told.

.. _Half my life spent in open source: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/59619

`Open source and open standards in VR`_
+++++++++++++++++++++++++++++++++++++++
By Stephanie Hurlburt

VR is cool! This talk wasn't especially insightful, beyond "Lots of VR
development is open source, here are some resources", but if you're
really stoked about VR it's likely worth watching.

.. _Open source and open standards in VR: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/59942

`The frontend dev's illustrated Rust adventure survival guide`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
By Liz Baillie

If this conference wasn't already chock full of outstanding talks, I
would say this was the best talk of the conference. In addition to
being a programmer Liz is a comic artist, storyteller, and game
developer, all of which came together in an illustrated (and narrated,
*with voices*) guide to Rust. I loved that Liz was totally silly
throughout the talk, and although the metaphor sometimes made her
points opaque some aspects of Rust are common knowledge enough that it
would make sense to most people. After describing her adventures in
"Rustlandia", Liz spoke about her programming experience with Rust,
and compared / contrasted writing a text-based game in Ruby and Rust.
This was a unique, fun, and informative talk delivered with
confidence, poise, and silliness all in good measure. The kind of
speaker I strive to be!!

.. _The frontend dev's illustrated Rust adventure survival guide: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/56823

`Making cross-browser testing beautiful`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
By Meaghan Lewis

I made a classic conference mistake with this talk: I already knew a
lot
about the subject. While I didn't gain any new insights, I was still impressed with the content and structure of the
talk! Meaghan covered common issues one might run in to when testing
using Selenium across multiple browsers, and what might be causing
those issues. She also prescribed some patterns that can help avoid
this issues (like using :code:`data-test` selectors in your html), and
talked about some general testing best practices. 

.. _Making cross-browser testing beautiful: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/55653

`Selling open source, keeping your soul`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
By Jessica Rose

This was like the talk version of a self-help book: mostly generic
advice that's really difficult to implement. Jessica seemed aware of
this, repeating a few times "This is easier said than done", but that
didn't make her content any more useful or meaningful. Such advice
included:

* Everyone in your organization should know what open source means to your org, and why it's important for your org
* Your open source org should balance transparency with too much information
* Collaborative conflict and compromise are what drive the product

And don't get me wrong, all of this is *great* advice. We should all
be transparent, and make compromises that drive our product, and be
open to feedback. We should also probably stop having so much pizza
and wine. By the end of the talk I didn't know any more about how to
have a successful open source company, or even what I could do to
advocate for open source within my company. A good topic, and good if
irrelevant advice, but overall and underwhelming talk.

.. _Selling open source, keeping your soul: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/57231

`Multilayered testing`_
~~~~~~~~~~~~~~~~~~~~~~~
By Alex Martelli

Honestly, by this point my brain was definitely not running on all
cylinders, so I can't say I got as much out of this talk as I might
have liked. But Alex presented an interesting idea: to have the same
set of tests run for both unit and integration tests, with the main
difference being mocked vs real dependencies (like databases, modules,
etc.). This gave you a unified set of tests, and helps avoid making
some 'white box' assumptions in unit tests. The rest of the talk went
through 'layers' of modules (from low-level modules that many things
depend on, to high-level ones that nothing depends on) and talked
about how to use unit and integration tests at each layer. Being in
QA, I think if I had a few more years of experience under my belt this
talk could have been *incredibly* valuable, and provided ideas for how
to apply these concepts in my job. At this point, though, it just
seems like a neat idea for Later Down the Road. 

.. _Multilayered testing: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/56591

Other Notes
-----------

As a speaker, I like to take note of interesting slides or speaking
techniques, and there were a number of great ones at this conference!
Here were a few notable speaking styles I admired:

* In `Step 1: Punch a Tree`_, I don't know that I can describe the slides but just watch the video and be in awe. This talk also included music and video, both of which I thought were used *very* well, which is *very* difficult. Standing ovation.
* 

Nicole Engard of Red Hat wrote a `nice article`_ about my talk! 

.. _nice article: https://opensource.com/article/17/5/making-your-first-open-source-contribution

Conclusion
----------

This was one of the better OSCONs I've been to, and I came away
inspired and excited about my industry and community. I learned that
the first step is to punch a tree, that TPM stands for more than just
`tethered particle motion`_, and that learning rust is just a
sea of bacon away. Looking forward to next year, when OSCON will be
back in my beautiful hometown `Portland`_. 


.. _Step 1\: Punch a Tree: https://conferences.oreilly.com/oscon/oscon-tx/public/schedule/detail/59367
.. _tethered particle motion: https://en.wikipedia.org/wiki/Tethered_particle_motion
.. _Portland: http://blog.lucywyman.me/portland.html
