<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xsl tei xd eg fn #default" extension-element-prefixes="exsl
    msxsl" version="1.0"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:eg="http://www.tei-c.org/ns/Examples" xmlns:exsl="http://exslt.org/common"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:template match="tei:pb[@facs]">
        <xsl:param name="pn">
            <xsl:number count="//tei:pb" level="any"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="$displayPageBreaks = true()">
                <!-- add @lang="en" to ensure correct ltr rendering -->
                <span class="-teibp-pb" lang="en">
                    <xsl:call-template name="addID"/>
                    <xsl:call-template name="templPbHandler">
                        <xsl:with-param name="n" select="@n"/>
                        <xsl:with-param name="facs" select="@facs"/>
                        <xsl:with-param name="id">
                            <xsl:choose>
                                <xsl:when test="@xml:id">
                                    <xsl:value-of select="@xml:id"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="generate-id()"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:with-param>
                    </xsl:call-template>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@* | node()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="templPbHandler">
        <xsl:param name="n"/>
        <xsl:param name="facs"/>
        <xsl:param name="id"/>
        <xsl:variable name="vFacsID" select="substring-after($facs, '#')"/>
        <!-- dealing with pointers instead of full URLs in @facs -->
        <xsl:variable name="vFacsUrl">
            <xsl:choose>
                <xsl:when test="starts-with($facs, '#')">
                    <!-- here could be an option to select the image hosted on HathiTrust -->
                    <xsl:choose>
                        <xsl:when test="$pgOnlineFacs = true()">
                            <xsl:choose>
                                <xsl:when
                                    test="ancestor::tei:TEI/tei:facsimile/tei:surface[@xml:id = $vFacsID]/tei:graphic[starts-with(@url, 'http://eap.')]">
                                    <xsl:value-of
                                        select="ancestor::tei:TEI/tei:facsimile/tei:surface[@xml:id = $vFacsID]/tei:graphic[starts-with(@url, 'http://eap.')][1]/@url"
                                    />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of
                                        select="ancestor::tei:TEI/tei:facsimile/tei:surface[@xml:id = $vFacsID]/tei:graphic[starts-with(@url, 'http://')][1]/@url"
                                    />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="ancestor::tei:TEI/tei:facsimile/tei:surface[@xml:id = $vFacsID]/tei:graphic[@mimeType = $vMimeType][1]/@url"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$facs"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="vFacsUrlOnline">
            <xsl:choose>
                <xsl:when test="starts-with($facs, '#')">
                    <!-- here could be an option to select the image hosted on HathiTrust -->
                    <xsl:choose>
                        <xsl:when
                            test="ancestor::tei:TEI/tei:facsimile/tei:surface[@xml:id = $vFacsID]/tei:graphic[starts-with(@url, 'http://eap.')]">
                            <xsl:value-of
                                select="ancestor::tei:TEI/tei:facsimile/tei:surface[@xml:id = $vFacsID]/tei:graphic[starts-with(@url, 'http://eap.')][1]/@url"
                            />
                        </xsl:when>
                        <xsl:when
                            test="ancestor::tei:TEI/tei:facsimile/tei:surface[@xml:id = $vFacsID]/tei:graphic[starts-with(@url, 'http://babel.hathitrust.org')]">
                            <xsl:value-of
                                select="ancestor::tei:TEI/tei:facsimile/tei:surface[@xml:id = $vFacsID]/tei:graphic[starts-with(@url, 'http://babel.hathitrust.org')][1]/@url"
                            />
                        </xsl:when>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$facs"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="vFacsSource">
            <xsl:choose>
                <xsl:when
                    test="ancestor::tei:TEI/tei:facsimile/tei:surface[@xml:id = $vFacsID]/tei:graphic[starts-with(@url, 'http://eap.')]">
                    <xsl:text>EAP</xsl:text>
                </xsl:when>
                <xsl:when
                    test="ancestor::tei:TEI/tei:facsimile/tei:surface[@xml:id = $vFacsID]/tei:graphic[starts-with(@url, 'http://babel.hathitrust.org')]">
                    <xsl:text>HathiTrust</xsl:text>
                </xsl:when>
                <!--<xsl:when
                    test="ancestor::tei:TEI/tei:facsimile/tei:surface[@xml:id = $vFacsID]/tei:graphic[starts-with(@url, 'http://')]">
                    <xsl:text>HathiTrust</xsl:text>
                </xsl:when>-->
            </xsl:choose>
        </xsl:variable>
        <span class="-teibp-pageNum" lang="en">
            <!-- <xsl:call-template name="atts"/> -->
            <xsl:copy-of select="$pbNote"/>
            <xsl:value-of select="@n"/>
            <xsl:text> - </xsl:text> 
            <!-- provide link to online facsimile no matter what -->
            <a href="{$vFacsUrlOnline}" target="_blank">
                <xsl:value-of select="$altTextPbFacs"/>
                <xsl:text> on </xsl:text>
                <xsl:value-of select="$vFacsSource"/>
            </a>
        </span>
        <span class="-teibp-pbFacs">
            <a class="gallery-facs" rel="prettyPhoto[gallery1]">
                <xsl:attribute name="onclick">
                    <xsl:value-of select="concat('showFacs(', $apos, $n, $apos, ',', $apos, $vFacsUrl, $apos, ',', $apos, $id, $apos, ')')"/>
                </xsl:attribute>
                <img alt="{$altTextPbFacs}" class="-teibp-thumbnail">
                    <xsl:attribute name="src">
                        <xsl:value-of select="$vFacsUrl"/>
                    </xsl:attribute>
                </img>
            </a>
        </span>
    </xsl:template>
    
</xsl:stylesheet>