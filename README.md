---
title: "read me"
author: Till Grallert
date: $timestamp
---

This repository contains a customisation of [TEI Boilerplate](http://dcl.slis.indiana.edu/teibp/) adopted to the need of TEI editions of Arabic language material. TEI Boilerplate provides a  first display of TEI files in the browser based on XSLT 1 and without need for pre-processed HTML. For a first impression see the [example file in this repository](https://rawgit.com/tillgrallert/tei-boilerplate-arabic-editions/master/example/oclc_4770057679-i_60.TEIP5.xml).

The code has been developed in the context of the [Digital Muqtabas](https://github.com/tillgrallert/digital-muqtabas), [Digital Ḥaqāʾiq](https://github.com/tillgrallert/digital-haqaiq) and [Digital Manār](https://github.com/tillgrallert/digital-manar) projects.

The display is built around modular css files that are all loaded through a central call to `custom.css`. Changing the look of the headers from dark font on a light background to light font on dark background, for example, can be done be loading `teibp-heads-dark.css` instead of `teibp-heads-light.css`.

# known issues

As the original TEI Boilerplate suffers from a known bug that prevents the jump from a facsimile's thumbnail picture to the large version to work properly, this feature was disabled and replaced with a large two-column view of facsimile and digital text.

# Installation / use:

The code can either be used by downloading / cloning the repository and integrating it into one's own project or by simply linking `xslt-boilerplate/teibp.xsl` of this repository in the head of one's XML files. 

There are three variants, each in its own branch:

## 1. master

This branch is meant to be installed as part of the project it is used to render. All links to files are relative links only.

~~~{.xml}
<?xml-stylesheet type="text/xsl" href="https://rawgit.com/tillgrallert/tei-boilerplate-arabic-editions/master/xslt-boilerplate/teibp.xsl"?>
~~~

## 2. online

This branch needs no local installation. It can be used to load the online boilerplate for any TEI file and displays facsimile files using the link to online repositories.

~~~{.xml}
<?xml-stylesheet type="text/xsl" href="https://rawgit.com/tillgrallert/tei-boilerplate-arabic-editions/online/xslt-boilerplate/teibp.xsl"?>
~~~

## 3. online-local-facsimiles

This branch needs no local installation. It can be used to load the online boilerplate for any TEI file and display local facsimile files.

~~~{.xml}
<?xml-stylesheet type="text/xsl" href="https://rawgit.com/tillgrallert/tei-boilerplate-arabic-editions/online-local-facsimiles/xslt-boilerplate/teibp.xsl"?>
~~~