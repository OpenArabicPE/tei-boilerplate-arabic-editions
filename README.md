---
title: "read me"
author: Till Grallert
date: 2016-04-02 17:47:03
---

This repository contains a customisation of [TEI Boilerplate](http://dcl.slis.indiana.edu/teibp/) adopted to the need of TEI editions of Arabic language material. In general, TEI Boilerplate provides a  first display of TEI files in a web browser based on XSLT 1 and without the need for pre-processed HTML. Our customisation adds support for RTL scripts, a beautiful open source Arabic font (Khaled Hosny's [Amiri font](http://www.amirifont.org/) based on early 20th-century fonts developped by the Bulāq Press in Cairo), side-by-side display of text and facsimiles, a functional table of content, and links to the bibliographic metadata for every article (provided they are available). For a first impression see [the included example file from "Digital *Muqtabas*"](https://rawgit.com/tillgrallert/tei-boilerplate-arabic-editions/master/example/oclc_4770057679-i_60.TEIP5.xml).

The code has been developed in the context of the [Digital *Muqtabas*](https://github.com/tillgrallert/digital-muqtabas), [Digital *Ḥaqāʾiq*](https://github.com/OpenAraPE/digital-haqaiq) and [Digital *Manār*](https://github.com/OpenAraPE/digital-manar) projects.

In contrast to the original TEI Boilerplate, the display is built around modular xslt and css files that are all loaded through a central call to `teibp_parameters.xsl`, `teibp.css` and `teibp_custom.css`. 

<!-- Changing the look of the headers from dark font on a light background to light font on dark background, for example, can be done be loading `teibp-heads-dark.css` instead of `teibp-heads-light.css`. -->


# Installation / use:

In order to make use of XSLT 1 stylesheets in a web browser, one has to provide a link to the main stylesheet `teibp_parameters` in the head of one's TEI files:

~~~{.xml}
<?xml-stylesheet type="text/xsl" href="path-to-the-boilerplate-folder/teibp_parameters.xsl"?>
~~~ 

The boilerplate can be installed / used in three different ways:

1. By downloading the [latest release](https://github.com/tillgrallert/tei-boilerplate-arabic-editions/releases) or cloning the "master" branch of this repository and integrating it into one's own project. This gives you full command over the display of your files, guarantees that no dependencies will be broken, and allows you to display TEI files using boilerplate without an active internet connection.
2. By downloading only [`xslt-boilerplate/teibp_parameter.xsl`](xslt-boilerplate/teibp_parameter.xsl) from the "online" branch of this repository. This allows you to independently set various display parameters (see below) but otherwise make use of the current stylesheets as hosted on GitHub.
3. By linking [`xslt-boilerplate/teibp_parameter.xsl`](xslt-boilerplate/teibp_parameter.xsl) of this repository in the head of one's XML files. The repository comes with a (small) variety of standard settings all hosted in different branches that allow you to toggle between parameters. The two currently available branches are all set to display page breaks and facsimiles, to not display any line breaks, and to generate English interface text. They differ in which facsimiles are displayed:
    - display online facsimiles: `<?xml-stylesheet type="text/xsl" href="https://rawgit.com/tillgrallert/tei-boilerplate-arabic-editions/online/xslt-boilerplate/teibp.xsl"?>`
    - display local facsimiles: `<?xml-stylesheet type="text/xsl" href="https://rawgit.com/tillgrallert/tei-boilerplate-arabic-editions/online-local-facsimiles/xslt-boilerplate/teibp.xsl"?>`

# Set parameters:

Most features are toggled through parameters in [`xslt-boilerplate/teibp_parameter.xsl`](xslt-boilerplate/teibp_parameter.xsl). 

## 1. Display of page breaks and facsimiles

~~~{.xml}
<xsl:param name="p_display-page-breaks" select="true()"/>
~~~

## 2. Toggle between online and off-line facsimile files:

~~~{.xml}
<xsl:param name="p_display-online-facsimiles" select="true()"/>
~~~

## 3. Display of line breaks

~~~{.xml}
<xsl:param name="p_display-line-breaks" select="true()"/>
~~~

## 4. Toggle the language of interface text

Toggle between English and the language of your TEI encoded texts:

~~~{.xml}
<xsl:param name="p_lang-interface-same-as-text" select="false()"/>
~~~

Currently our boilerplate supports English (as fall-back option) and Arabic, but one can easily add additional languages to all parameters that begin with `p_text-`; e.g.

~~~{.xml}
<xsl:param name="p_text-page">
        <span class="c_teibp-pbNote" lang="{$v_lang-interface}">
            <xsl:choose>
                <xsl:when test="$v_lang-interface = 'ar'">
                    <xsl:text>صفحة</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>page</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:param>
~~~

To add another language just add another `<xsl:when>` option; e.g.

~~~{.xml}
<xsl:param name="p_text-page">
        <span class="c_teibp-pbNote" lang="{$v_lang-interface}">
            <xsl:choose>
                <xsl:when test="$v_lang-interface = 'ar'">
                    <xsl:text>صفحة</xsl:text>
                </xsl:when>
                <xsl:when test="$v_lang-interface = 'de'">
                    <xsl:text>Seite</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>page</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:param>
~~~
