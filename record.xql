xquery version "3.0";

declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace vra="http://www.vraweb.org/vracore4.htm";
declare namespace bf="http://betterform.sourceforge.net/xforms";
declare namespace bfc="http://betterform.sourceforge.net/xforms/controls";
declare namespace xf="http://www.w3.org/2002/xforms";

(:  rosids-shared :)
import module namespace app="http://github.com/hra-team/rosids-shared/config/app" at "/apps/rosids-shared/modules/ziziphus/config/app.xqm";

declare %private function local:transformVraRecord($record as node(), $uuid as xs:string, $vraRecordType as xs:string, $language as xs:string, $schema as xs:string) {
    let $parameters := <parameters>
                        <param  name="recordType" value="{$vraRecordType}"/>
                        <param name="recordId" value="{$uuid}"/>
                        <param  name="codetables-uri" value="{substring-before(request:get-url(), '/apps') || $app:code-tables}"/>
                        <param  name="resources-uri" value="{substring-before(request:get-url(), '/apps') || $app:ziziphus-resources-dir || 'lang/'}"/>
                        <param  name="lang" value="{$language}"/>
                        <param  name="schema" value="{$schema}"/>
                    </parameters>
    let $transform := transform:transform($record, doc($app:ziziphus-resources-dir ||  "/xsl/vra-record.xsl"), $parameters)
    return
        $transform
};

declare function local:displayImageArea($vraWorkRecord as node()) {
    <div class="imagePanel">
        {
            if (exists($vraWorkRecord))
            then (
                for $image in $vraWorkRecord/vra:relationSet
                    let $imageId  :=    if(exists($vraWorkRecord/vra:relationSet/vra:relation/@pref[.='true']))
                                        then (
                                            $vraWorkRecord/vra:relationSet/vra:relation[@pref='true'][1]/@relids
                                        ) else (
                                            $vraWorkRecord/vra:relationSet/vra:relation[1]/@relids
                                        )
                    return
                        <img src="/exist/apps/tamboti/modules/display/image.xql?schema=IIIF&amp;call=/{$imageId}/full/full/0/default.jpg" alt="" class="relatedImage"/>
                    ) else ()
        }
    </div>
};

let $uuid := request:get-parameter('id', '')
let $workdir := request:get-parameter('workdir', '')
let $workRecordDir as xs:string := if($workdir eq '') then ($app:ziziphus-default-record-dir) else ($workdir)
let $imageDir as xs:string := $workRecordDir || $app:image-record-dir-name
let $vraWorkRecord  := app:get-resource($uuid)
let $imageRecordId  :=  if(exists($vraWorkRecord/vra:relationSet/vra:relation/@pref[.='true']))
                        then (
                            $vraWorkRecord/vra:relationSet/vra:relation[@pref='true'][1]/@relids
                        ) else (
                            $vraWorkRecord/vra:relationSet/vra:relation[1]/@relids
                        )
let $vraImageRecord := app:get-resource($imageRecordId)
let $language := request:get-parameter('language', 'en')
let $schema := request:get-parameter('schema', 'cluster')

return
<html xmlns:exist="http://exist.sourceforge.net/NS/exist" xmlns="http://www.w3.org/1999/xhtml" xmlns:ev="http://www.w3.org/2001/xml-events" xmlns:bf="http://betterform.sourceforge.net/xforms" xmlns:vra="http://www.vraweb.org/vracore4.htm" xmlns:meta="http://expath.org/ns/pkg" xmlns:bfc="http://betterform.sourceforge.net/xforms/controls" xmlns:xf="http://www.w3.org/2002/xforms" bf:transform="/apps/ziziphus/resources/xsl/ziziphus.xsl">
    <head>
        <title>Ziziphus VRA editor {substring-before(request:get-url(), '/apps') || $app:code-tables}</title>
        <link href="/exist/apps/rosids-shared/resources/script/vendor/select2/select2.css" rel="stylesheet"/>
        <link rel="stylesheet" href="/exist/apps/rosids-shared/resources/script/vendor/font-awesome/css/font-awesome.min.css"/>
        <link rel="stylesheet" type="text/css" href="resources/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="resources/css/layout.css"/>
        <link rel="stylesheet" type="text/css" href="resources/css/record.css"/>
        <link rel="stylesheet" type="text/css" href="resources/script/mingos-uwindow/themes/ziziphus/style.css"/>
        <link rel="stylesheet" type="text/css" href="resources/script/layout-default-latest.css"/>
        <link rel="stylesheet" type="text/css" href="resources/css/jquery-ui.css"/>
        <link rel="stylesheet" type="text/css" href="resources/css/animate.css"/>
        <!-- <link rel="stylesheet" type="text/css" href="/exist/apps/rosids-shared/resources/css/autocomplete.css"/> -->
        <link rel="stylesheet" type="text/css" href="/exist/apps/rosids-shared/resources/css/select2-cluster.css"/>

        <!--<link rel="stylesheet" type="text/css" href="resources/css/ui-lightness/jquery-ui-1.10.2.custom.min.css"/>-->
    </head>
    <body>
        <div id="overlay" style="position:absolute;z-index:9999;width:100%;height:100%;background:#444444;">
            <span style="font-weight:bold; font-size:200% !important;position:absolute;top:50%;width:100%;text-align:center;">... loading Ziziphus Image Database</span>
        </div>
        <div style="display:none">
            <xf:model id="m-main">
                <xf:instance id="i-control-center">
                    <data xmlns="">
                        <currentform/>
                        <!-- Which record to save/load, used by subform -->
                        <workdir/>
                        <imagepath/>
                        <uuid/>
                        <workrecord/>
                        <imagerecord/>
                        <changed/>
                        <setname/>
                        <isDirty>false</isDirty>
                        <language>en</language>
                        <schema>cluster</schema>
                    </data>
                </xf:instance>



                <xf:setvalue ev:event="xforms-model-construct-done" ref="instance('i-control-center')/uuid" value="bf:appContext('id')"/>
                <xf:setvalue ev:event="xforms-model-construct-done" ref="instance('i-control-center')/workrecord" value="bf:appContext('id')"/>
                <xf:setvalue ev:event="xforms-model-construct-done" ref="instance('i-control-center')/workdir" value="bf:appContext('workdir')"/>
                <xf:action ev:event="xforms-model-construct-done">
                    <xf:setvalue ref="instance('i-control-center')/language" value="bf:appContext('language')"/>
                    <xf:setvalue ref="instance('i-control-center')/language" value="'en'" if="instance('i-control-center')/language eq ''"/>
                </xf:action>
                <xf:setvalue ev:event="xforms-model-construct-done" ref="instance('i-control-center')/imagepath" value="substring-before(bf:appContext('imagepath'), '#')"/>

                <xf:submission id="s-get-imagerecord-id" method="get" replace="text" ref="instance('i-control-center')" targetref="imagerecord" serialization="none">
                    <xf:resource value="concat('modules/records/image-record-id.xql?uuid=', instance('i-control-center')/uuid)"/>
                </xf:submission>

                <xf:submission method="get" id="s-refresh" replace="embedHTML" resource="modules/refreshSection.xql" targetid="{{concat(instance('i-control-center')/currentform,'_HtmlContent')}}">
                    <xf:action ev:event="xforms-submit-done">
                        <!-- ##### reset 'changed' flag which is set whenever a section was updated in the db ###### -->
                        <xf:setvalue ref="instance('i-control-center')/changed" value="'false'"/>
                        <script>
                            initTextExpand();
                        </script>
                    </xf:action>
                </xf:submission>

                <xf:submission id="s-delete" method="get" replace="none">
                    <xf:resource value="concat('modules/records/delete.xql?uuid=', instance('i-control-center')/uuid)"/>
                    <xf:message ev:event="xforms-submit-error">Could not delete workrecord</xf:message>
                    <xf:action ev:event="xforms-submit-done">
                        <xf:load show="replace">
                            <xf:resource value="bf:appContext('http-headers/referer')"/>
                        </xf:load>
                    </xf:action>
                </xf:submission>

                <xf:instance xmlns="" id="i-user">
                    <data/>
                </xf:instance>

                <xf:bind nodeset="instance('i-user')">
                    <xf:bind nodeset="user">
                        <xf:bind nodeset="@edit" relevant="boolean-from-string(.)"/>
                    </xf:bind>
                </xf:bind>

                <xf:submission id="s-load-user-data" method="post" replace="instance" instance="i-user">
                    <xf:resource value="IF(instance('i-control-center')/workdir eq '', 'modules/getUserData.xql', concat('modules/getUserData.xql?workdir=', encode-for-uri(instance('i-control-center')/workdir)))"/>
                    <xf:message ev:event="xforms-submit-error">Error receiving the current user</xf:message>
                </xf:submission>

                <xf:instance id="i-meta">
                    <data xmlns=""/>
                </xf:instance>
                <xf:submission id="s-load-metadata" method="get" resource="expath-pkg.xml" replace="instance" ref="instance('i-meta')"/>



                <xf:action ev:event="xforms-ready">
                    <xf:send submission="s-load-user-data"/>
                    <xf:send submission="s-load-metadata"/>
                    <xf:send submission="s-get-imagerecord-id"/>
                </xf:action>

                <!-- i18n helper-->
                <!-- i18n helper-->
                <!-- i18n helper-->

                <xf:instance id="i-refresh">
                    <data xmlns="">
                        <uuid/>
                        <setname/>
                        <workdir/>
                        <language>en</language>
                        <currentform/>
                    </data>
                </xf:instance>

                <xf:submission method="get" id="s-refresh-view" replace="embedHTML" instance="i-refresh" targetid="{{concat(instance('i-refresh')/currentform,'_HtmlContent')}}">
                    <xf:resource value="concat('modules/refreshSection.xql?setname=', bf:instanceOfModel('m-main', 'i-refresh')/setname, '&amp;uuid=', bf:instanceOfModel('m-main', 'i-refresh')/uuid,'&amp;workdir=', bf:instanceOfModel('m-main', 'i-refresh')/workdir, '&amp;language=', bf:instanceOfModel('m-main', 'i-refresh')/language)"/>
                </xf:submission>

            </xf:model>


            <xf:model id="m-code-tables">
                <xf:instance xmlns="" id="i-codes-lang" src="modules/code-tables.xql?table=lang"/>
                <xf:instance xmlns="" id="i-codes-script" src="modules/code-tables.xql?table=script"/>
                <xf:instance xmlns="" id="i-codes-transliteration" src="modules/code-tables.xql?table=transliteration"/>
                <xf:instance xmlns="" id="i-codes-role" src="modules/code-tables.xql?table=role"/>
            </xf:model>


            <!-- i18n -->
            <!-- i18n -->
            <!-- i18n -->
            <xf:model id="m-lang">
                <xf:instance xmlns="" id="i-lang" src="resources/lang/lang_en.xml"/>

                <xf:submission id="s-load-lang" method="get" replace="instance" ref="instance('i-lang')" serialization="none">
                    <xf:resource value="concat('resources/lang/lang_', bf:instanceOfModel('m-main', 'i-control-center')/language, '.xml')"/>
                    <xf:action ev:event="xforms-submit">
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/language" value="bf:instanceOfModel('m-main', 'i-control-center')/language"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/uuid"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/workdir" value="bf:instanceOfModel('m-main', 'i-control-center')/workdir"/>
                    </xf:action>
                    <xf:action ev:event="xforms-submit-done">
                        <xf:message level="ephemeral">Refreshing view</xf:message>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/setname" value="'agentSet'"/>

                        <!-- Workrecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/workrecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'w_Agent'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>
                        <!-- Imagerecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/imagerecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'i_Agent'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/setname" value="'DateSet'"/>

                        <!-- Workrecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/workrecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'w_Date'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>
                        <!-- Imagerecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/imagerecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'i_Date'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/setname" value="'DescriptionSet'"/>

                        <!-- Workrecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/workrecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'w_Description'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>
                        <!-- Imagerecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/imagerecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'i_Description'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/setname" value="'LocationSet'"/>

                        <!-- Workrecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/workrecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'w_Location'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <!-- Imagerecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/imagerecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'i_Location'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/setname" value="'RightsSet'"/>

                        <!-- Workrecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/workrecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'w_Rights'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <!-- Imagerecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/imagerecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'i_Rights'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/setname" value="'SubjectSet'"/>

                        <!-- Workrecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/workrecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'w_Subject'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <!-- Imagerecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/imagerecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'i_Subject'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/setname" value="'TitleSet'"/>

                        <!-- Workrecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/workrecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'w_Title'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <!-- Imagerecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/imagerecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'i_Title'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/setname" value="'CulturalContextSet'"/>

                        <!-- Workrecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/workrecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'w_CulturalContext'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <!-- Imagerecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/imagerecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'i_CulturalContext'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/setname" value="'InscriptionSet'"/>

                        <!-- Workrecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/workrecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'w_Inscription'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <!-- Imagerecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/imagerecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'i_Inscription'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/setname" value="'MaterialSet'"/>

                        <!-- Workrecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/workrecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'w_Material'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <!-- Imagerecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/imagerecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'i_Material'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/setname" value="'MeasurementsSet'"/>

                        <!-- Workrecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/workrecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'w_Measurements'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <!-- Imagerecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/imagerecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'i_Measurements'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/setname" value="'RelationSet'"/>

                        <!-- Workrecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/workrecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'w_Relation'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <!-- Imagerecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/imagerecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'i_Relation'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/setname" value="'SourceSet'"/>

                        <!-- Workrecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/workrecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'w_Source'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <!-- Imagerecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/imagerecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'i_Source'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/setname" value="'StateEditionSet'"/>

                        <!-- Workrecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/workrecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'w_StateEdition'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <!-- Imagerecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/imagerecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'i_StateEdition'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/setname" value="'StylePeriodSet'"/>

                        <!-- Workrecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/workrecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'w_StylePeriod'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>


                        <!-- Imagerecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/imagerecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'i_StylePeriod'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/setname" value="'TechniqueSet'"/>

                        <!-- Workrecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/workrecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'w_Technique'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <!-- Imagerecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/imagerecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'i_Technique'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/setname" value="'TextrefSet'"/>

                        <!-- Workrecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/workrecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'w_Textref'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <!-- Imagerecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/imagerecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'i_Textref'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/setname" value="'WorktypeSet'"/>

                        <!-- Workrecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/workrecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'w_Worktype'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <!-- Imagerecord -->
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/uuid" value="bf:instanceOfModel('m-main', 'i-control-center')/imagerecord"/>
                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-refresh')/currentform" value="'i_Worktype'"/>
                        <xf:send model="m-main" submission="s-refresh-view"/>

                        <xf:setvalue ref="bf:instanceOfModel('m-main', 'i-control-center')/changed" value="'false'"/>
                        <xf:action>
                            <script>
                                initTextExpand();
                            </script>
                        </xf:action>
                    </xf:action>
                </xf:submission>
            </xf:model>
            <xf:bind nodeset="instance('i-lang')" model="m-lang">
                <xf:bind nodeset="help" type="anyURI"/>
            </xf:bind>
            <xf:trigger>
                <xf:label>Capture return</xf:label>
            </xf:trigger>
            <xf:submit id="t-delete-workrecord" submission="s-delete">
                <xf:label/>
            </xf:submit>
            <xf:trigger id="t-open-workrecord-in-tamboti">
                <xf:load show="new">
                    <xf:resource value="concat('/exist/apps/tamboti/modules/search/index.html?search-field=ID&amp;value=', instance('i-control-center')/workrecord)"/>
                </xf:load>
            </xf:trigger>
            <xf:trigger id="t-load-xml">
                <xf:load show="new">
                    <xf:resource value="concat('modules/loadXML.xql?id=', instance('i-control-center')/workrecord)"/>
                </xf:load>
            </xf:trigger>
            <xf:trigger id="t-load-xml-image">
                <xf:load show="new">
                    <xf:resource value="concat('modules/loadXML.xql?id=', instance('i-control-center')/workrecord, '&amp;type=image')"/>
                </xf:load>
            </xf:trigger>
            <xf:group id="controlCenter" model="m-main">
                <xf:action ev:event="unload-subform" model="m-main" if="string-length(instance('i-control-center')/currentform) &gt; 0">
                    <xf:send submission="s-refresh" if="changed='true'"/>
                    <xf:toggle>
                        <xf:case value="concat('c-',instance('i-control-center')/currentform,'-view')"/>
                    </xf:toggle>
                    <xf:load show="none" targetid="{{concat(instance('i-control-center')/currentform,'_MountPoint')}}"/>
                    <!-- ##### reset isDirty flag ##### -->
                    <xf:setvalue ref="instance('i-control-center')/isDirty" value="'false'"/>
                    <xf:setvalue ref="instance('i-control-center')/currentform"/>
                </xf:action>
                <xf:action ev:event="clear-currentform" model="m-main">
                    <xf:setvalue ref="instance('i-control-center')/currentform" value="''"/>
                </xf:action>
            </xf:group>
            <xf:input id="workdir" ref="instance('i-control-center')/workdir">
                <xf:label>Hidden Control</xf:label>
            </xf:input>
            <xf:input id="workrecordid" ref="instance('i-control-center')/workrecord">
                <xf:label>Hidden Control</xf:label>
            </xf:input>
        </div>
        <div id="issue-window"/>
        <!-- window for heidicon data -->
        <div id="heidiconWindow" current="{$uuid}"></div>

        <!-- window for versions history -->
        <div id="versionsWindow"/> <!--TODO: something to do with templates, like here: class="main:getid" -->

        <!-- ######################## main content area ################# -->
        <!-- ######################## main content area ################# -->
        <!-- ######################## main content area ################# -->
        <div class="ui-layout-north" style="overflow:hidden;">
            <div id="headerTitle" style="float:left;display:block;">
                <ul class="inline" style="list-style:none outside none;margin-left:0;padding:0">
                    <li>
                        <div class="btn-group">
                            <button type="button" class="btn" id="report-issue">report an issue</button>
                        </div>
                    </li>
                    <li>
                        <div class="btn-group">
                            <button type="button" class="btn" id="heidicon">Heidicon Data</button>
                        </div>
                    </li>
                    <li>
                        <div class="btn-group">
                            <button id="workpicture" class="btn icon" type="button" onclick="leftCenter();" title="show Workrecord+Picture">W | P</button>
                            <button id="workpictureimage" class="btn icon" type="button" onclick="allCols();" title="show Workrecord, Picture + Imagerecord">W | P | I</button>
                            <button id="pictureimage" class="btn icon" type="button" onclick="centerRight();" title="show Picture + Imagerecord">P | I</button>
                        </div>
                    </li>
                    <li>
                        <div class="btn-group">
                            <!-- button id="showXML" class="btn icon" type="button" title="show raw XML" onclick="showWorkXML();">XML</button-->
                        </div>
                    </li>
                    <li>
                        <div class="btn-group">
                            <button id="delete-workrecord" class="btn icon" type="button" onclick="deleteRecord();" title="Delete current workrecord and related imagerecords">Delete</button>
                        </div>
                    </li>
                    <li>
                        <div class="btn-group">
                            <button id="open-workrecord-in-tamboti" class="btn" type="button" onclick="openWorkrecordInTamboti();" title="Open current workrecord in Tamboti">
                                <i class="fa fa-folder-open"/> Tamboti</button>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="headerMenu" style="position:absolute;display:block;right:40px;">
                <ul class="inline" style="list-style:none outside none;margin-left:0;padding:0">
                    <li>
                        <span class="btn-group" style="display:none">
                            <xf:select1 id="s-schema" model="m-main" ref="instance('i-control-center')/schema" incremental="true">
                                <xf:label>Schema</xf:label>
                                <xf:item>
                                    <xf:label>VRA</xf:label>
                                    <xf:value>vra</xf:value>
                                </xf:item>
                                <xf:item>
                                    <xf:label>EXC</xf:label>
                                    <xf:value>cluster</xf:value>
                                </xf:item>
                            </xf:select1>
                        </span>
                    </li>
                    <li>
                        <span class="btn-group">
                            <xf:select1 id="s-lang" model="m-main" ref="instance('i-control-center')/language" incremental="true">
                                <xf:label>Language</xf:label>
                                <xf:action ev:event="xforms-value-changed">
                                    <xf:send model="m-lang" submission="s-load-lang"/>
                                </xf:action>
                                <xf:item>
                                    <xf:label>Deutsch</xf:label>
                                    <xf:value>de</xf:value>
                                </xf:item>
                                <xf:item>
                                    <xf:label>English</xf:label>
                                    <xf:value>en</xf:value>
                                </xf:item>
                            </xf:select1>
                        </span>
                    </li>
                    <li>
                        <xf:output id="user" ref="instance('i-user')/user/@name">
                            <xf:label>User:</xf:label>
                            <xf:hint ref="instance('i-meta')/@version"/>
                        </xf:output>
                    </li>
                    <li>
                        <xf:trigger class="btn-group -btn">
                            <xf:label>Logout</xf:label>
                            <xf:load resource="?logout=true" show="replace"/>
                        </xf:trigger>
                    </li>
                </ul>
            </div>
        </div>
        <!--
        <div class="ui-layout-south">
            <xf:output ref="instance('i-meta')/@version">
                <xf:label>Version: </xf:label>
            </xf:output>
        </div>
        -->

        <div class="ui-layout-west">
            { local:transformVraRecord($vraWorkRecord, $uuid, 'work', $language, $schema) }
        </div>
        <div class="ui-layout-east">
            { local:transformVraRecord($vraImageRecord, $imageRecordId, 'image', $language, $schema) }
        </div>
        <div class="ui-layout-center">
            {local:displayImageArea($vraWorkRecord)}
        </div>


        <!-- ######################################### -->
        <!-- ######################################### -->
        <!-- ######################################### -->
        <script type="text/javascript">
            require(["dojo/parser",
                "dijit/TitlePane"
            ]);
        </script>
        <script type="text/javascript" src="resources/script/jquery-1.9.1.js"/>
        <!--<script type="text/javascript" src="resources/script/jquery-ui-1-1.10.0.custom/js/jquery-ui-1.10.0.custom.min.js"/>-->
        <script type="text/javascript" src="resources/script/jquery-ui-1.10.2.custom.min.js"/>
        <script type="text/javascript" src="resources/script/mingos-uwindow/jWindow.js"/>
        <script type="text/javascript" src="resources/script/jquery.layout-latest.min.js"/>
        <!--
            <script type="text/javascript" src="/exist/apps/rosids-shared/resources/script/vendor/typeahead.js/hogan-2.0.0.js"/>
            <script type="text/javascript" src="/exist/apps/rosids-shared/resources/script/vendor/typeahead.js/typeahead-0.9.3.js"/>
            <script type="text/javascript" src="/exist/apps/rosids-shared/resources/script/typeahead-init.js"/>
        -->
        <script type="text/javascript" src="/exist/apps/rosids-shared/resources/script/vendor/select2/select2.js"/>
        <script type="text/javascript" src="/exist/apps/rosids-shared/resources/script/select2/select2-init.js"/>
        <script type="text/javascript" src="/exist/apps/rosids-shared/resources/script/select2/select2-multiple.js"/>
        <script type="text/javascript" src="/exist/apps/rosids-shared/resources/script/select2/select2-names.js"/>
        <script type="text/javascript" src="/exist/apps/rosids-shared/resources/script/select2/select2-subjects.js"/>
        <script type="text/javascript" src="resources/script/text-expand.js"/>
        <script type="text/javascript" src="resources/script/ziziphus.js"/>
    </body>
</html>