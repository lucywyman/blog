Setting a Language with Selenium Webdriver in Ruby
==================================================
:date: 2017-01-23
:tags: tech, ruby, selenium
:category: Tech
:slug: setting-a-language-with-selenium-webdriver-in-ruby
:author: Lucy Wyman

Hello reader! This post was inspired by a project I was working on
recently, adding a 'lang' option to a `Selenium-Webdriver`_ (the ruby
gem) wrapper. I needed to instantiate
`Selenium::Webdriver`_.for(:firefox) and (:chrome) both locally and
remotely (Sauce labs, specifically), setting a locale
for each.  There's plenty of documentation on how to do this in
`Java`_, `C`_, and even `Python`_, but it was hard to find the right
way to do it using the ruby gem. So here's what worked for me, where
:code:`@@sweep_options[:lang]` is just a variable that holds either
'en-us' or 'ja' (as strings).

.. _Selenium-Webdriver: https://rubygems.org/gems/selenium-webdriver/versions/2.53.4
.. _Selenium\:\:Webdriver: http://www.rubydoc.info/gems/selenium-webdriver/0.0.28/Selenium/WebDriver/Driver
.. _Java: http://stackoverflow.com/questions/18645205/set-chromes-language-using-selenium-chromedriver
.. _C: 
.. _Python: http://sqa.stackexchange.com/questions/9904/how-to-set-browser-locale-with-chromedriver-python

Locally
~~~~~~~

Firefox
-------

.. code-block:: ruby

    firefox_profile = Selenium::WebDriver::Firefox::Profile.new
    firefox_profile['intl.accept_languages'] = @@sweep_options[:lang]
    Selenium::WebDriver.for(:firefox, 
                            :http_client => client, 
                            :profile => firefox_profile)

Chrome
------

.. code-block:: ruby

    chrome_prefs = { :lang => @@sweep_options[:lang] }
    Selenium::WebDriver.for(:chrome, 
                            :http_client => client, 
                            :prefs => chrome_prefs, 
                            :desired_capabilities => caps)


Remotely
~~~~~~~~

Firefox
-------

.. code-block:: ruby

    firefox_profile = Selenium::WebDriver::Firefox::Profile.new
    firefox_profile['intl.accept_languages'] = @@sweep_options[:lang]
    caps = Selenium::WebDriver::Remote::Capabilities.firefox(:firefox_profile => firefox_profile)
    sweep_driver = Selenium::WebDriver.for(
        :remote,
        :http_client          => client,
        :url                  => URL,
        :desired_capabilities => caps)

Chrome
------

.. code-block:: ruby

    caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => 
                                                     {"args" => ["--lang=#{@@sweep_options[:lang]}"]})
    sweep_driver = Selenium::WebDriver.for(
        :remote,
        :http_client          => client,
        :url                  => URL,
        :desired_capabilities => caps)




Resources
~~~~~~~~~

* https://sites.google.com/a/chromium.org/chromedriver/capabilities
* https://github.com/SeleniumHQ/selenium/wiki/DesiredCapabilities
