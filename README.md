# ABAP-Meterdata-Manager
ABAP Meterdata-Manager is a legacy code refactoring kata based in the utilities domain. It was first presented at [ABAPConf 2022](https://www.abapconf.org)

## What is this about?
You just started a new job at a local utility company. A colleague had his last day at work yesterday. He quit because he won the lottery. He developed the "meterdata manager" for about 25 years. It's a very important piece of software because... well, you actually dont really understand what the collegaue told you about the code. Some stuff about "billing", "meter readings", "overflow"  etc. You have a look at the code and it looks awful. But you know there are new feature request from the PO, so you need to improve the code. Let's get started.

## How to use this kata
You can copy and paste the sourccode into your system or simply clone this repository with [ABAPGit](https://abapgit.org/).
There are a few important objects:
* zcl_meterdata_manager - the class you want to refactor
* zcl_meterdata_manager_setup - run this before you start, it will initialize the database
* zbillit - a function module. treat it like a SAP standard FM / external dependency. You can't control whats happening inside.

To get things going you can start with safe recatorings, approval tests or unit tests.


## I need help - what does the header / comments and VKS / ZEABL mean?
If you dont speak german just put the header into google translate. Same for the comments. But don't expect too much ;-)
SAP historically often uses german words. Maybe you can guess the meaning of VKS and ZEABL from the context (hint Z is just the namespace and E stands for "energy"). Its part of the kata to find out what these things mean and refactor to a consitent ubiquitious language.

## I need help - what does this class actually do?
In every household there is an electicity meter. Every first day of the month the customers check the meter and type the meter reading value into our mobile app. This app uploads the meter reading to our SAP system. When the 12th meter reading value gets uploaded to the system, the 12 meterreadings should be validated. If everything is fine the customers contract will be billed  (thats what the FM does).

This kata (or any ABAP kata imho) is no fun to do with SE80. [Please use Eclipse/ADT](https://developers.sap.com/tutorials/abap-install-adt.html).

Enjoy! PRs are welcome.

Greetings,
Dominik

follow me on [Twittter](https://twitter.com/PanzerDominik) or [Mastodon](https://sw-development-is.social/web/@PanzerDominik)
