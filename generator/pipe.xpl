<?xml version="1.0"?>
<p:declare-step 
    xmlns:p="http://www.w3.org/ns/xproc" 
    xmlns:c="http://www.w3.org/ns/xproc-step"
    version="1.0" 
    name="inlineXsdExtensionPipeline">
    <p:input port="source">
        <p:document href="xsd/vra.xsd"/>
    </p:input>
    
    <p:output port="result">
        <p:pipe step="vraWithInlinedExtension" port="result"/>
    </p:output>
    
    <p:xslt name="inlineXsdExtension">
        <p:input port="source"/>
        <p:input port="stylesheet">
            <p:document href="xsl/01_XSD_Inline_Extension.xsl"/>
        </p:input>
        <p:with-param name="debug" select="'false'"/>
    </p:xslt>
    
    
    <p:xslt name="inlineXSD">
        <p:input port="source"/>
        <p:input port="stylesheet">
            <p:document href="xsl/02_InlineXSD.xsl"/>
        </p:input>
        <p:with-param name="debug" select="'false'"/>
    </p:xslt>
    
    <p:xslt name="applySchemaRedifinition">
        <p:input port="source"/>
        <p:input port="stylesheet">
            <p:document href="xsl/03_Apply_Schema_Redefintion.xsl"/>
        </p:input>
        <p:with-param name="debug" select="'false'"/>
        <p:with-param name="path2schemaRedefinition" select="'../xsd/vra-strict.xsd'"/>
    </p:xslt>
    
    <p:xslt name="splitSchemaTypes">
        <p:input port="source"/>
        <p:input port="stylesheet">
            <p:document href="xsl/04_Split_Schema.xsl"/>
        </p:input>
        <p:with-param name="debug" select="'true'"/>
        <p:with-param name="path2schemaDir" select="'/Users/windauer/dev/eXist/apps/ziziphus/generator/build/xsd'"/>
        <p:with-param name="vraTypeSchemaName" select="'vra-types.xsd'"/>
    </p:xslt>
    
    <p:store href="build/xsd/vra-bf.xsd" name="vraWithInlinedExtension"/>
    
    
</p:declare-step>
