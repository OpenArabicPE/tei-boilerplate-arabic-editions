<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xsl tei xd eg fn #default" version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template name="t_get-entity-from-authority-file">
        <xsl:param name="p_entity-name"/>
        <xsl:param name="p_local-authority" select="'oape'"/>
        <xsl:param name="p_authority-file"/>
        <xsl:variable name="v_ref" select="$p_entity-name/@ref"/>
        <xsl:variable name="v_entity-type">
            <xsl:choose>
                <xsl:when test="local-name($p_entity-name) = 'persName'">
                    <xsl:text>pers</xsl:text>
                </xsl:when>
                <xsl:when test="local-name($p_entity-name) = 'orgName'">
                    <xsl:text>org</xsl:text>
                </xsl:when>
                <xsl:when test="local-name($p_entity-name) = 'placeName'">
                    <xsl:text>place</xsl:text>
                </xsl:when>
                <xsl:when test="local-name($p_entity-name) = 'title'">
                    <xsl:text>bibl</xsl:text>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:variable>
        <!-- both $v_authority and $v_idno are correct -->
        <xsl:variable name="v_authority">
            <!-- order matters here: while our local IDs must be unique, we can have multiple entries pointing to the same ID in an external reference file -->
            <xsl:choose>
                <xsl:when test="contains($v_ref, $p_local-authority)">
                    <xsl:value-of select="$p_local-authority"/>
                </xsl:when>
                <xsl:when test="contains($v_ref, 'jaraid:')">
                    <xsl:text>jaraid</xsl:text>
                </xsl:when>
                <xsl:when test="contains($v_ref, 'oape:')">
                    <xsl:text>oape</xsl:text>
                </xsl:when>
                <xsl:when test="contains($v_ref, 'damascus:')">
                    <xsl:text>damascus</xsl:text>
                </xsl:when>
                <xsl:when test="contains($v_ref, 'viaf:')">
                    <xsl:text>VIAF</xsl:text>
                </xsl:when>
                <xsl:when test="contains($v_ref, 'geon:')">
                    <xsl:text>geon</xsl:text>
                </xsl:when>
                <xsl:when test="contains($v_ref, 'geonames.org')">
                    <xsl:text>geon</xsl:text>
                </xsl:when>
                <xsl:when test="contains($v_ref, 'oclc:')">
                    <xsl:text>OCLC</xsl:text>
                </xsl:when>
                <xsl:when test="contains($v_ref, 'wiki:')">
                    <xsl:text>Wikidata</xsl:text>
                </xsl:when>
                <xsl:when test="starts-with($v_ref, 'http')">
                    <xsl:text>url</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$p_local-authority"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="v_local-uri-scheme" select="concat($v_authority, ':', $v_entity-type, ':')"/>
        <xsl:variable name="v_idno">
            <xsl:variable name="v_temp">
                <xsl:choose>
                    <!-- the sort order here must match the one in $v_authority -->
                    <xsl:when test="contains($v_ref, $v_local-uri-scheme)">
                        <xsl:value-of select="substring-after($v_ref, $v_local-uri-scheme)"/>
                    </xsl:when>
                    <xsl:when test="contains($v_ref, 'viaf:')">
                        <xsl:value-of select="substring-after($v_ref, 'viaf:')"/>
                    </xsl:when>
                    <xsl:when test="contains($v_ref, 'geon:')">
                        <xsl:value-of select="substring-after($v_ref, 'geon:')"/>
                    </xsl:when>
                    <xsl:when test="contains($v_ref, 'geonames.org/')">
                        <xsl:value-of select="substring-after($v_ref, 'geonames.org/')"/>
                    </xsl:when>
                    <xsl:when test="contains($v_ref, 'oclc:')">
                        <xsl:value-of select="substring-after($v_ref, 'oclc:')"/>
                    </xsl:when>
                    <xsl:when test="contains($v_ref, 'wiki:')">
                        <xsl:value-of select="substring-after($v_ref, 'wiki:')"/>
                    </xsl:when>
                    <xsl:when test="contains($v_ref, '^http')">
                        <xsl:value-of select="substring-after($v_ref, 'http')"/>
                    </xsl:when>
                    <!--<xsl:when test="contains($v_ref, $v_local-uri-scheme)"><!-\- local IDs in Project Jaraid are not nummeric for biblStructs -\-><xsl:value-of select="replace($v_ref, concat('.*', $v_local-uri-scheme, '(\w+).*'), '$1')"/></xsl:when>-->
                </xsl:choose>
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="contains($v_temp, ' ')">
                    <xsl:value-of select="substring-before($v_temp, ' ')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$v_temp"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!-- output -->
        <xsl:variable name="v_message-failure">
            <xsl:value-of select="'NA'"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$v_entity-type = 'pers'">
                <xsl:choose>
                    <xsl:when test="$p_authority-file//tei:person/tei:idno[@type = $v_authority] = $v_idno">
                        <xsl:copy-of select="$p_authority-file//tei:person[tei:idno[@type = $v_authority] = $v_idno]"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$v_message-failure"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$v_entity-type = 'org'">
                <xsl:choose>
                    <xsl:when test="$p_authority-file//tei:org/tei:idno[@type = $v_authority] = $v_idno">
                        <xsl:copy-of select="$p_authority-file//tei:org[tei:idno[@type = $v_authority] = $v_idno]"/>
                    </xsl:when>
                    <xsl:otherwise>
                       <xsl:value-of select="$v_message-failure"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$v_entity-type = 'place'">
                <xsl:choose>
                    <xsl:when test="$p_authority-file//tei:place/tei:idno[@type = $v_authority] = $v_idno">
                        <xsl:apply-templates mode="m_pop-up-entity" select="$p_authority-file//tei:place[tei:idno[@type = $v_authority] = $v_idno]"/>
                    </xsl:when>
                    <!-- everything works as expected -->
                    <xsl:otherwise>
                        <xsl:value-of select="$v_message-failure"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$v_entity-type = 'bibl'">
                <xsl:choose>
                    <xsl:when test="$p_authority-file//tei:biblStruct/tei:monogr/tei:idno[@type = $v_authority] = $v_idno">
                        <xsl:apply-templates mode="m_pop-up-entity" select="$p_authority-file//tei:biblStruct[tei:monogr/tei:idno[@type = $v_authority] = $v_idno]"/>
                    </xsl:when>
                    <!-- everything works as expected -->
                    <xsl:otherwise>
                        <xsl:value-of select="$v_message-failure"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <!-- fallback message -->
            <xsl:otherwise>
                <!-- one cannot use a boolean value if the default result is non-boolean -->
                <xsl:value-of select="'NA'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="node()" mode="m_plain-text">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template match="tei:biblStruct" mode="m_pop-up-entity">
        <xsl:variable name="v_lang" select="tei:monogr/tei:textLang/@mainLang"/>
        <span class="c_bibl">
            <xsl:choose>
                <xsl:when test="tei:monogr/tei:title[not(@type = 'sub')][@xml:lang = $v_lang]">
                    <xsl:apply-templates mode="m_plain-text" select="tei:monogr/tei:title[not(@type = 'sub')][@xml:lang = $v_lang][1]"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates mode="m_plain-text" select="tei:monogr/tei:title[not(@type = 'sub')][1]"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="tei:monogr/tei:title[@type = 'sub'][@xml:lang = $v_lang]">
                <xsl:text>: </xsl:text>
                <xsl:choose>
                    <xsl:when test="tei:monogr/tei:title[@type = 'sub'][@xml:lang = $v_lang]">
                        <xsl:apply-templates mode="m_plain-text" select="tei:monogr/tei:title[@type = 'sub'][@xml:lang = $v_lang][1]"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates mode="m_plain-text" select="tei:monogr/tei:title[@type = 'sub'][1]"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <!-- editor -->
            <xsl:if test="tei:monogr/tei:editor">
                <xsl:text>, </xsl:text>
                <xsl:for-each select="tei:monogr/tei:editor">
                    <xsl:choose>
                        <xsl:when test="tei:persName[@xml:lang = $v_lang]">
                            <xsl:apply-templates mode="m_plain-text" select="tei:persName[@xml:lang = $v_lang]"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates mode="m_plain-text" select="tei:persName[1]"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="following-sibling::tei:editor">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </xsl:if>
            <!-- imprint -->
            <xsl:if test="tei:monogr/tei:imprint/tei:pubPlace">
                <xsl:text>, </xsl:text>
                <xsl:choose>
                    <xsl:when test="tei:monogr/tei:imprint/tei:pubPlace/tei:placeName[@xml:lang = $v_lang]">
                        <xsl:apply-templates mode="m_plain-text" select="tei:monogr/tei:imprint/tei:pubPlace/tei:placeName[@xml:lang = $v_lang]"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates mode="m_plain-text" select="tei:monogr/tei:imprint/tei:pubPlace/tei:placeName[1]"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="tei:monogr/tei:imprint/tei:publisher">
                    <xsl:text>: </xsl:text>
                    <xsl:apply-templates mode="m_plain-text" select="tei:monogr/tei:imprint/tei:publisher/node()[@xml:lang = $v_lang]"/>
                </xsl:if>
            </xsl:if>
            <!-- date -->
            <xsl:if test="tei:monogr/tei:imprint/tei:date">
                <xsl:text>, </xsl:text>
                <xsl:choose>
                    <xsl:when test="tei:monogr/tei:imprint/tei:date[@type = 'onset']">
                        <xsl:apply-templates mode="mBibl" select="tei:monogr/tei:imprint/tei:date[@type = 'onset']"/>
                    </xsl:when>
                </xsl:choose>
                <xsl:if test="tei:monogr/tei:imprint/tei:date[@type = 'terminus']">
                    <xsl:text>– </xsl:text>
                    <xsl:apply-templates mode="mBibl" select="tei:monogr/tei:imprint/tei:date[@type = 'terminus']"/>
                </xsl:if>
            </xsl:if>
            <!-- pages -->
            <xsl:if test="tei:monogr/tei:biblScope[@unit = 'page']">
                <xsl:text>, </xsl:text>
                <xsl:value-of select="tei:monogr/tei:biblScope[@unit = 'page']/@to - tei:monogr/tei:biblScope[@unit = 'page']/@from + 1"/>
                <xsl:text>ص</xsl:text>
            </xsl:if>
        </span>
        <!-- information on languages -->
        <!-- potentially add holdings -->
        <!--  -->
        <xsl:if test="tei:monogr/tei:idno">
            <br/>
            <span class="c_ids" lang="en">
                <xsl:apply-templates mode="m_link" select="tei:monogr/tei:idno"/>
            </span>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:place" mode="m_pop-up-entity">
        <!-- this has been declared in the parameter file -->
        <xsl:variable name="v_lang" select="$v_lang-interface"/>
        <span class="c_place">
            <xsl:choose>
                <xsl:when test="tei:placeName[@xml:lang = $v_lang]">
                    <xsl:for-each select="tei:placeName[@xml:lang = $v_lang]">
                        <xsl:apply-templates mode="m_plain-text" select="."/>
<!--                        <xsl:if test="not(last())">-->
                            <xsl:text>, </xsl:text>
                        <!--</xsl:if>-->
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates mode="m_plain-text" select="tei:placeName[1]"/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
        <!-- IDs -->
        <xsl:if test="tei:idno">
            <br/>
            <span class="c_ids" lang="en">
                <xsl:apply-templates mode="m_link" select="tei:idno"/>
            </span>
        </xsl:if>
    </xsl:template>
    <!-- generate links only for the first ID of each type -->
    <xsl:template match="tei:idno[not(preceding-sibling::tei:idno[@type = current()/@type])]" mode="m_link">
        <xsl:choose>
            <xsl:when test="@type = 'wiki'">
                <a href="https://wikidata.org/wiki/{.}" target="_blank">Wikidata:
                    <xsl:value-of select="."/></a>
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'OCLC'">
                <a href="https://worldcat.org/oclc/{.}" target="_blank">OCLC: 
                    <xsl:value-of select="."/></a>
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'geon'">
                <a href="http://www.geonames.org/{.}" target="_blank">GeoNames:
                    <xsl:value-of select="."/></a>
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'oape'">
                <a href="https://openarabicpe.github.io" target="_blank">OpenArabicPE</a>
                <xsl:text>: </xsl:text>
                <xsl:value-of select="."/>
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'jaraid'">
                <a href="https://projectjaraid.github.io" target="_blank">Project Jarāʾid</a>
                <xsl:text>: </xsl:text>
                <xsl:value-of select="."/>
                <xsl:text> </xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:idno" mode="m_link"/>
    <!-- input: @ref, output: a single <html:a>-->
    <xsl:template name="t_derefence-ref">
        <xsl:param name="p_ref"/>
        <xsl:param name="p_content"/>
        <xsl:choose>
            <xsl:when test="contains($p_ref, 'viaf:')">
                <xsl:call-template name="t_derefence-ref-link">
                    <xsl:with-param name="p_ref" select="$p_ref"/>
                    <xsl:with-param name="p_content" select="$p_content"/>
                    <xsl:with-param name="p_authority" select="'viaf:'"/>
                    <xsl:with-param name="p_authority-url" select="'https://viaf.org/viaf/'"/>
                    <xsl:with-param name="p_authority-name" select="'VIAF'"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="contains($p_ref, 'geon:')">
                <xsl:call-template name="t_derefence-ref-link">
                    <xsl:with-param name="p_ref" select="$p_ref"/>
                    <xsl:with-param name="p_content" select="$p_content"/>
                    <xsl:with-param name="p_authority" select="'geon:'"/>
                    <xsl:with-param name="p_authority-url" select="'https://www.geonames.org/'"/>
                    <xsl:with-param name="p_authority-name" select="'GeoNames'"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="contains($p_ref, 'oclc:')">
                <xsl:call-template name="t_derefence-ref-link">
                    <xsl:with-param name="p_ref" select="$p_ref"/>
                    <xsl:with-param name="p_content" select="$p_content"/>
                    <xsl:with-param name="p_authority" select="'oclc:'"/>
                    <xsl:with-param name="p_authority-url" select="'https://www.worldcat.org/oclc/'"/>
                    <xsl:with-param name="p_authority-name" select="'WorldCat'"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="contains($p_ref, 'wiki:')">
                <xsl:call-template name="t_derefence-ref-link">
                    <xsl:with-param name="p_ref" select="$p_ref"/>
                    <xsl:with-param name="p_content" select="$p_content"/>
                    <xsl:with-param name="p_authority" select="'wiki:'"/>
                    <xsl:with-param name="p_authority-url" select="'https://wikidata.org/wiki/'"/>
                    <xsl:with-param name="p_authority-name" select="'Wikidata'"/>
                </xsl:call-template>
            </xsl:when>
            <!-- fallback! -->
            <xsl:otherwise>
                <xsl:copy-of select="$p_content"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="t_derefence-ref-link">
        <xsl:param name="p_ref"/>
        <xsl:param name="p_content"/>
        <xsl:param name="p_authority"/>
        <xsl:param name="p_authority-url"/>
        <xsl:param name="p_authority-name"/>
        <xsl:variable name="v_multiple-values">
            <xsl:choose>
                <xsl:when test="contains(substring-after($p_ref, $p_authority), ' ')">
                    <xsl:copy-of select="true()"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <a class="c_linked-data" lang="en" target="_blank">
            <xsl:attribute name="href">
                <xsl:value-of select="$p_authority-url"/>
                <xsl:choose>
                    <xsl:when test="$v_multiple-values = 'false'">
                        <xsl:value-of select="substring-after($p_ref, $p_authority)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="substring-before(substring-after($p_ref, $p_authority), ' ')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:text>Link to this entity at </xsl:text>
                <xsl:value-of select="$p_authority-name"/>
            </xsl:attribute>
            <xsl:copy-of select="$p_content"/>
        </a>
    </xsl:template>
</xsl:stylesheet>
