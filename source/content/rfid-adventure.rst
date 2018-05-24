RFID (mis)Adventure
===================
:date: 05-22-2018
:tags: tech, experiences
:category: Tech
:slug: RFID-adventure
:author: Lucy Wyman
:image:

Our office recently relocated to a WeWork, which has an RFID card for
getting onto the floor before business hours and for getting into our
company's suite there. Unfortunately I already have an RFID card (my
`Orca card`_) attached to my phone, so keeping the WeWork card there
was a no-go. Keeping it in my wallet is also an option, but I don't
typically carry my wallet with me around the office, especially since
I have a limited number of outfits that have pockets. The ideal
solution for my RFID card woes would be something I could wear on my
body, that didn't need to be carried and could easily be passed by the
readers while I was juggling a water bottle and laptop. Something
like...a bracelet! So I set out to copy my WeWork RFID onto an RFID
bracelet. Long story short: I failed, I think because the super-cheap
RFID reader/writer I bought was *too* cheap. But I wanted to blog
about it anyway in an effort to `write about my failures as well as my
successes`_. For science!

.. _Orca card: https://kingcounty.gov/depts/transportation/metro/fares-orca/orca-cards.aspx
.. _write about my failures as well as my successes: http://time.com/3206754/publication-bias-null-results/

The Windows VM
--------------

I started out by purchasing the following:

- `RFID reader/writer`_
- `RFID Bracelets`_

After spending about an hour researching Linux utilities for RFID
readers/writers, I decided I should just use the software on the CD
that came with the copier. It was a .exe of course, so the first order
of business was spinning up a windows VM on my machine. The first snag
I hit was that the CD could only be installed on 32-bit Windows, not
64-bit, so after getting my 64-bit `Windows 8.1 VM`_ setup I had to
tear it down and find a vagrant box for `32-bit Windows`_. 'Snag'
might be a strong word there, it was mostly just annoying and time
consuming. This is `the Vagrantfile`_ I ended up using. Important to
note that in addition to the particular Windows VM, I also needed to
mount the copier device to the VM.

.. _RFID reader/writer: https://www.amazon.com/125KHZ-Reader-Writer-Duplicator-Control/dp/B079HVQXQY/ref=sr_1_4?ie=UTF8&qid=1526008775&sr=8-4&keywords=rfid+writer#customerReviews
.. _RFID Bracelets: https://www.amazon.com/YARONGTECH-13-56MHZ-ISO14443A-Silicone-wristband/dp/B01FR63GVG/ref=sr_1_5?ie=UTF8&qid=1526008799&sr=8-5&keywords=rfid+bracelet#customerReviews
.. _Windows 8.1 VM:  http://aka.ms/ie11.win81.vagrant
.. _32-bit Windows: https://app.vagrantup.com/mrh1997/boxes/vanilla-win7-32bit
.. _the Vagrantfile: https://gist.github.com/lucywyman/373c7a4352bb207bc41d57eb774e66fe 

The Copier
----------

With the software installed, and the correct device mounted so I could
connect the copier to the Windows VM, it was time to copy RFIDs! Or so
I thought. The copier beeped when I plugged it in, and successfully
connected to the GUI. Yay! I put my WeWork card on it and clicked
'Read'. It turned red and made angry beeping noises. Boo. I collected
a few other RFIDs I had around the house -- my Orca card, the badge
from our Portland office, my passport -- and tried those as well, all
without success. Maybe I was doing it wrong? The copier came with some
blank RFID tags, so I put one on the copier and wrote random data to
it. It beeped successfully and turned green. Sigh. 

That's really all there was to it. My copier seemed to be working, but
didn't have the right frequencies for the things I actually needed to
read. Forgetting / losing my WeWork card continues to be a problem, so
stayed tuned for other attempts at the bracelet solution or other
creative solutions to the problem! 
