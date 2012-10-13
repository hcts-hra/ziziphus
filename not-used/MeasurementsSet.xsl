<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" version="2.0" exclude-result-prefixes="vra">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

    <xsl:template name="handleMeasure">
        <xsl:value-of select="."/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="@unit"/>
    </xsl:template>

    <!-- single <measurements> element -->
    <xsl:template match="vra:measurementsSet/vra:measurements" priority="40">
        <xsl:call-template name="handleMeasure"/>

        <xsl:choose>
            <xsl:when test="@type='depth'">
                <xsl:text> (D)</xsl:text>
            </xsl:when>
            <xsl:when test="@type='height'">
                <xsl:text> (H)</xsl:text>
            </xsl:when>
            <xsl:when test="@type='length'">
                <xsl:text> (L)</xsl:text>
            </xsl:when>
            <xsl:when test="@type='width'">
                <xsl:text> (W)</xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- single <measurements> element; full item title (sometimes) -->
    <xsl:template match="vra:measurementsSet/vra:measurements" mode="itemTitle">
        <xsl:choose>
            <xsl:when test="@type='depth'">
                <xsl:text>Depth: </xsl:text>
            </xsl:when>
            <xsl:when test="@type='height'">
                <xsl:text>Height: </xsl:text>
            </xsl:when>
            <xsl:when test="@type='length'">
                <xsl:text>Length: </xsl:text>
            </xsl:when>
            <xsl:when test="@type='width'">
                <xsl:text>Width: </xsl:text>
            </xsl:when>
        </xsl:choose>

        <xsl:call-template name="handleMeasure"/>
    </xsl:template>

    <!-- multiple <measurements> elements, single extent, multiple type -->
    <xsl:template name="handleMeasurementsMulti">
        <xsl:param name="mgTitle"/>
        <!-- minimal required number of elements to use the common title (mgTitle);
             if there are less, we use individual item titles.
        -->
        <xsl:param name="mgTitleMin">0</xsl:param>
        <xsl:param name="mgElems"/>
        <xsl:param name="miSepa">, </xsl:param>

        <xsl:variable name="mgTitleMinV" select="number($mgTitleMin)"/>
        <xsl:variable name="commonTitle" select="$mgTitleMinV &lt;= count($mgElems)"/>

        <xsl:if test="$mgElems">
            <span class="measurementsRecord">
            <xsl:if test="$commonTitle">
                <span class="measureType"><xsl:value-of select="$mgTitle"/></span>
            </xsl:if>
            <xsl:for-each select="$mgElems">
                <xsl:if test="position() &gt; 1">
                    <xsl:value-of select="$miSepa"/>
                </xsl:if>

                <xsl:choose>
                    <xsl:when test="$commonTitle">
                        <xsl:apply-templates select="current()"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="current()" mode="itemTitle"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            </span>
        </xsl:if>
    </xsl:template>

    <!-- multiple <measurements> elements, single extent, single type -->
    <xsl:template name="handleMeasurements">
        <xsl:param name="miTitle"/>
        <xsl:param name="miType"/>
        <xsl:param name="miSepa"/>

        <xsl:call-template name="handleMeasurementsMulti">
            <xsl:with-param name="mgTitle" select="$miTitle"/>
            <xsl:with-param name="mgElems" select="current-group()[@type=$miType]"/>
            <xsl:with-param name="miSepa"  select="$miSepa"/>
        </xsl:call-template>
    </xsl:template>

    <!-- multiple <measurements> elements, single extent -->
    <xsl:template name="handleMeasurementsGroup">
        <xsl:call-template name="handleMeasurements">
            <xsl:with-param name="miTitle">Weight</xsl:with-param>
            <xsl:with-param name="miType">weight</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="handleMeasurements">
            <xsl:with-param name="miTitle">Size</xsl:with-param>
            <xsl:with-param name="miType">size</xsl:with-param>
        </xsl:call-template>

        <xsl:call-template name="handleMeasurements">
            <xsl:with-param name="miTitle">Count</xsl:with-param>
            <xsl:with-param name="miType">count</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="handleMeasurements">
            <xsl:with-param name="miTitle">Distance between</xsl:with-param>
            <xsl:with-param name="miType">distanceBetween</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="handleMeasurements">
            <xsl:with-param name="miTitle">Area</xsl:with-param>
            <xsl:with-param name="miType">area</xsl:with-param>
        </xsl:call-template>

        <xsl:call-template name="handleMeasurementsMulti">
            <xsl:with-param name="mgTitle">Dimensions</xsl:with-param>
            <xsl:with-param name="mgTitleMin">2</xsl:with-param>
            <xsl:with-param name="mgElems" select="current-group()[(@type='depth') or (@type='height') or (@type='length') or (@type='width')]"/>
            <xsl:with-param name="miSepa"> x </xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="handleMeasurements">
            <xsl:with-param name="miTitle">Diameter</xsl:with-param>
            <xsl:with-param name="miType">diameter</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="handleMeasurementsMulti">
            <xsl:with-param name="mgTitle">Circumference</xsl:with-param>
            <!-- VRA Core 4 schema typos:
                    http://www.loc.gov/standards/vracore/vra-strict.xsd : circumfrence
                    http://www.loc.gov/standards/vracore/VRA_Core4_Element_Description.pdf : circumferance
            -->
            <xsl:with-param name="mgElems" select="current-group()[(@type='circumferance') or (@type='circumfrence') or (@type='circumference')]"/>
        </xsl:call-template>

        <xsl:call-template name="handleMeasurements">
            <xsl:with-param name="miTitle">File size</xsl:with-param>
            <xsl:with-param name="miType">fileSize</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="handleMeasurements">
            <xsl:with-param name="miTitle">Resolution</xsl:with-param>
            <xsl:with-param name="miType">resolution</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="handleMeasurements">
            <xsl:with-param name="miTitle">Bit depth</xsl:with-param>
            <xsl:with-param name="miType">bit-depth</xsl:with-param>
        </xsl:call-template>

        <xsl:call-template name="handleMeasurements">
            <xsl:with-param name="miTitle">Duration</xsl:with-param>
            <xsl:with-param name="miType">duration</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="handleMeasurements">
            <xsl:with-param name="miTitle">Running time</xsl:with-param>
            <xsl:with-param name="miType">runningTime</xsl:with-param>
        </xsl:call-template>

        <xsl:call-template name="handleMeasurements">
            <xsl:with-param name="miTitle">Scale</xsl:with-param>
            <xsl:with-param name="miType">scale</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="handleMeasurements">
            <xsl:with-param name="miTitle">Base</xsl:with-param>
            <xsl:with-param name="miType">base</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="handleMeasurements">
            <xsl:with-param name="miTitle">Target</xsl:with-param>
            <xsl:with-param name="miType">target</xsl:with-param>
        </xsl:call-template>

        <xsl:call-template name="handleMeasurements">
            <xsl:with-param name="miTitle">Other</xsl:with-param>
            <xsl:with-param name="miType">other</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="vra:measurementsSet" priority="40">
                <!-- type: area, base, bit-depth (for born-digital work), circumferance, count, depth, diameter, distanceBetween, duration, fileSize (for born-digital work), height, length, resolution (for born-digital work), runningTime, scale (for maps), size, target (for use with scale), weight, width, other. -->

                <!-- concat with '#' is used here to handle measurements with missing 'extent' attributes (i.e.: global) -->
                <xsl:for-each-group select="vra:measurements" group-by="concat('#', @extent)">
                    <xsl:sort select="current-grouping-key()"/>

                    <!-- global measurements come first, the other are details -->
                    <xsl:choose>
                        <xsl:when test="'#' = current-grouping-key()">
                            <span class="measurementsExtent">
                            <xsl:call-template name="handleMeasurementsGroup"/>
                            </span>
                        </xsl:when>
                        <xsl:otherwise>
                            <span class="measurementsExtent detail">
                            <span class="measurementsExtent-name"><xsl:value-of select="substring(current-grouping-key(),2)"/></span>
                            <xsl:call-template name="handleMeasurementsGroup"/>
                            </span>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each-group>
    </xsl:template>
</xsl:stylesheet>
