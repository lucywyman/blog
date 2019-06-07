RedHat Summit 2019 Trip Report
==============================
:date: 05-09-2019
:tags: tech, conferences
:category: Tech
:slug: redhat-summit-2019-trip-report
:author: Lucy Wyman
:img: rhs-sign.jpg

This was a *fantastic* conference experience. It was so energizing and
exciting to see people interact with Bolt and understand it, and I was
surprised by how much I loved getting to tell people about it and demo
it. I hadn't realized how proud I was of Bolt, or how receptive to it
passers by would be. It was so rewarding to meet people who were using
and loving Bolt, people who lit up when I told them about it, and
people who came back later in the conference with friends to have us
show them Bolt as well!

Most of my interactions were overwhelmingly positive - because of the
split-background booth those who approached us had heard of Puppet
and often used or liked it, but had not heard of Bolt. A brief
breakdown of the folx we talked to.
**NOTE**: These are just **estimates** and only represent the people I
talked to.

* 70%-80% of people had heard of or used Puppet, but had
  not heard of Bolt
* 10 or so people were already using Bolt (or about 5% of the
  people I talked to)
* Of the people who were using Puppet, I'd estimate that 70%-80% were
  using Ansible to run Puppet (or 48%-64% of everyone).
* About 10-15% of people asked if Bolt had a GUI or RBAC, and we
  directed them to PE
* Most people seemed genuinely interested in Bolt - there were of
  course people who just wanted socks or stickers, and it's
  impossible to gauge if interest was just polite or genuine. But
  given the amount of time some folks stuck around and their
  questions, their interest seemed earnest.
* Only one dog visited the booth, and she mostly seemed interested in
  getting pets not in Bolt or Puppet.

Bolt Use Cases
--------------

There were 4 main demos we had, and I'd say 90% of people were
'looking for' or excited about one of those use cases.

* Running commands: For some users, just being able to run ad-hoc
  commands across infra with Bolt was compelling. This was especially
  useful for the few people who were new to the industry or
  automation, or for demonstrating the basic concept of Bolt to those
  who didn't use Ansible. I'd say 75-80% of people didn't care that
  much about this demo though and wanted to know about more complex
  features.
* YAML Plans: This feature *paid off*. A lot of people would look
  skeptical when I introduced the concept of plans until I said they
  could write them in YAML, and then would nod vigorously or smile or
  make the 'not bad' face. They said the YAML was much more readable and
  familiar, and would allow them to immediately get started writing
  plans. I also used this opportunity to brag about writing the YAML -
  Puppet transpiler; some people were clearly like "I will never use
  that", others thought it was cool and could see the benefits of
  eventually using Puppet for plans (though this may also just have been
  social politeness).
* Network Devices: A handful of people (maybe 10-20 over the course of
  2 days?) *really* cared about this feature, and everyone else did not
  care at all. It was very binary: if the user was a networking engineer
  this was pretty much the only feature they cared about, and if they
  weren't a network engineer they did not care about it at all. It was
  hard to have in-depth conversations about it because Alex and I are
  not networking experts, but it was clear that there was demand for
  more device support here. The devices everyone asked about were F5,
  Juniper (sp?), and what Cisco architectures (might not be the right
  word?) we supported. We also talked to a number of contracts or
  support folks who thought their clients would be interested in this.
* Lastly was applying Puppet code from plans. This was great as the
  last demo because usually by this point people asked "So how is Bolt
  different from Ansible?", and talking about embedding declarative code
  into an imperative Bolt plan was a good difference to show them. The
  script-ness of Bolt plans resonated for some, and fell flat for
  others. I think for those who were *just* using Ansible and not Puppet
  the value proposition wasn't enough to warrant switching.  But for
  users who were familiar with Puppet, or had gotten to advanced enough
  Ansible that having a more script-like syntax was appealing, this was
  definitely a good selling point.

Questions
---------

We had a number of good conversations, and some common questions came
up:

1. How is Bolt better than Ansible if I'm not already using Puppet?
2. How is Bolt different from Ansible?
3. Does it have encrypted secret storage?

I was surprised that people were totally fine with a manual inventory,
at least when it came up - I don't remember anyone asking about
inventory plugins or generating inventory. A few asked about getting
nodes from PuppetDB, but mostly because they were already using Puppet
and PuppetDB. 

Conclusion
----------

Our presence at RedHat Summit was, at least by me, a huge success. We
succeeded in getting a lot of people excited about Bolt, had great
visibility at the conference, and had many interesting, engaging, and
educating conversations.

We could not have pulled this off without an *incredible* team, and
I'm humbled by what amazing coworkers I get to work with across the
Puppet organization.
* Our sales reps are knowledgable and engaging, and so good at making
  customers feel heard and empowered. Huge thanks to Dylan and Supriya!
* Our sales engineers understood customer problems
  and what they wanted to see in the demos - shout out to Paul Reed for
  taking us from a 1-node demo to a 60 node demo that ran in a loop, all
  in 10 minutes! So many people commented on how fast Bolt was, and
  seeing Bolt work across infra had so much more impact than on just 1
  or 2 VMs. Stephen Potter and Matthew Stone did a fantastic job
  introducing people to Puppet and Bolt, drawing them in to the booth,
  and showing off Puppet Enterprise.
* Isaiah (and I think others
  throughout marketing) did an incredible job of making Bolt's
  presence known. Between the pedicabs, the socks, the stickers, and
  most of all the booth, 'Bolt' was on people's minds and lips - I
  heard people wondering aloud what "Bolt" was as I walked by the
  pedicabs to lunch one day!
* This event absolutely could not have happened without Claire
  coordinating. Everyone knew when and where to be, swag and promo
  materials appeared as if by magic thanks to her, and the whole
  conference ran like clockwork. She saw a need for us to have 'Bolt
  business cards', and instead of taking a note to do it later she
  *made it happen* in just a few hours.
* And of course thanks to the Bolt team. Yasmin and Alex's knowledge
  of Bolt (not to mention stamina with talking to attendees for 2 and a
  half days straight) was obviously helpful in technical discussions
  about how Bolt works and fits into workflows. But the whole Bolt
  team - Nick Lewis, Cas Donoghue, Ethan Brown - are what make this
  such a productive, thoughtful, and smart team to work with, and it
  shows in the project.

And that's all she wrote! Feel free to ask follow up questions in #bolt on
slack, or to PM me directly.
