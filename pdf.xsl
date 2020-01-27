<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.semestralkaMS.cz/LS2018"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:s="http://www.semestralkaMS.cz/LS2018" exclude-result-prefixes="s" version="2.0">

    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <fo:root language="cs" font-family="Arial">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4" page-height="297mm" page-width="210mm">
                    <fo:region-body margin="2cm"/>
                    <fo:region-before extent="1cm"/>
                    <fo:region-after extent="1cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="A4">
                
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block text-align="center" margin-top="5mm">
                        <xsl:text>Zákazníkova objednávka číslo : </xsl:text><xsl:value-of select="s:dodacíList/s:Header/s:CisObj"/><fo:leader leader-pattern="dots"/><xsl:text> vyexportováno do PDF dne : </xsl:text><xsl:value-of select="current-date()"/>
                    </fo:block>
                </fo:static-content>

                <fo:static-content flow-name="xsl-region-after">
                    <fo:block text-align="center">
                        <xsl:text>Strana </xsl:text>
                        <fo:page-number/>
                        <xsl:text> / </xsl:text>
                        <fo:page-number-citation ref-id="posledni"/>
                    </fo:block>
                </fo:static-content>

                <fo:flow flow-name="xsl-region-body">
                    <fo:block text-align="center" font-size="200%">
                        <fo:inline font-weight="bold">Dodací list</fo:inline>
                    </fo:block>
                    
                    <xsl:apply-templates/>
                    
                    <xsl:for-each select="s:dodacíList/s:Položky/s:Položka">
                        <xsl:sort select="s:CenaZaKus" data-type="number" order="descending"></xsl:sort>
                        <fo:block id="{generate-id()}" break-before="page">
                            Identifikační Číslo : <xsl:value-of select="s:IdentifikačníČíslo"/>
                        </fo:block>
                        <fo:block>
                            Popis : <xsl:value-of select="s:Popis"></xsl:value-of>
                        </fo:block>
                        <fo:block>
                            Barva : <xsl:value-of select="s:Barva"></xsl:value-of>
                        </fo:block>
                        <fo:block>
                            Materiál : <xsl:value-of select="s:Materiál"/>
                        </fo:block>
                        <fo:block>
                            Pohlaví : <xsl:value-of select="s:Pohlaví"/>
                        </fo:block>
                        <fo:block>
                            Velikost : <xsl:value-of select="s:Velikost"/>
                        </fo:block>
                        <fo:block>
                            Cena za jeden kus : <xsl:value-of select="s:CenaZaKus"/><xsl:value-of select="s:CenaZaKus/@měna"/>
                        </fo:block>
                        <fo:block>
                            Množství : <xsl:value-of select="s:Mnozstvi"/><xsl:value-of select="s:Mnozstvi/@jednotky"/>
                        </fo:block>
                        <fo:block>
                            Značka : <xsl:value-of select="s:Značka"/>
                        </fo:block>
                        <fo:block>
                            Text : <xsl:value-of select="s:TXT"/>
                        </fo:block>
                        <fo:block>
                            Náhled : <xsl:apply-templates select="s:FotoURI"/>
                        </fo:block>
                    </xsl:for-each>
                    <fo:block id="posledni"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <xsl:template match="s:FotoURI">
        <fo:block>
            <fo:external-graphic src="{.}" content-width="5cm" width="40%"
                text-align="center" display-align="center"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="s:DodaciList">
        <fo:block> Dodací list: <xsl:value-of select="."/>
        </fo:block>
    </xsl:template>

    <xsl:template match="s:CisObj">
        <fo:block>Číslo objednávky: <xsl:value-of select="."/></fo:block>
    </xsl:template>

    <xsl:template match="s:DatumDodání">
        <fo:block>Datum dodání: <xsl:value-of select="."/></fo:block>
    </xsl:template>

    <xsl:template match="s:ObjZak">
        <fo:block>Objednávka zákazníka: <xsl:value-of select="."/></fo:block>
    </xsl:template>

    <xsl:template match="s:Dodavatel">
        <fo:block-container>
            <fo:block margin-right="10cm" margin-top="5mm" margin-bottom="5mm" padding="3mm"
                border-style="solid" border-width="0.3mm">
                <fo:inline font-weight="bold">Dodavatel</fo:inline>
                <xsl:apply-templates/>
            </fo:block>
        </fo:block-container>
    </xsl:template>

    <xsl:template match="s:Nazev">
        <fo:block>Společnost: <xsl:value-of select="."/>
        </fo:block>
    </xsl:template>

    <xsl:template match="s:Mesto">
        <fo:block>Město: <xsl:value-of select="."/>
        </fo:block>
    </xsl:template>

    <xsl:template match="s:Ulice">
        <fo:block>Ulice: <xsl:value-of select="."/>
        </fo:block>
    </xsl:template>

    <xsl:template match="s:PSC">
        <fo:block>PSČ: <xsl:value-of select="."/>
        </fo:block>
    </xsl:template>

    <xsl:template match="s:Zakaznik">
        <fo:block-container>
            <fo:block margin-right="10cm" margin-top="5mm" padding="3mm" border-style="solid"
                border-width="0.3mm">
                <fo:inline font-weight="bold">Zakazník <xsl:value-of select="./@typ"/></fo:inline>
                <xsl:apply-templates/>
            </fo:block>
        </fo:block-container>
    </xsl:template>


    <xsl:template match="s:Položky">
        <fo:block margin-top="5mm" break-before="page">
            <fo:inline font-weight="bold">Objednané položky</fo:inline>
        </fo:block>
        <fo:table space-before="5mm">
            <fo:table-column border-width="0.1mm" border-style="solid" column-width="2cm"/>
            <fo:table-column border-width="0.1mm" border-style="solid" column-width="5cm"/>
            <fo:table-column border-width="0.1mm" border-style="solid" column-width="3cm"/>
            <fo:table-column border-width="0.1mm" border-style="solid" column-width="3cm"/>
            <fo:table-column border-width="0.1mm" border-style="solid" column-width="3cm"/>
            <fo:table-header font-weight="bold" border-width="0.1mm" border-style="solid">
                <fo:table-row>
                    <fo:table-cell padding="3mm">
                        <fo:block>Detail položky</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="3mm">
                        <fo:block>Identifikační číslo</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="3mm">
                        <fo:block>Popis</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="3mm">
                        <fo:block>Jednotková cena</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="3mm">
                        <fo:block>Množství</fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <xsl:apply-templates/>
            </fo:table-body>
        </fo:table>
    </xsl:template>


    <xsl:template match="s:Položka">           
        <fo:table-row border-width="0.1mm" border-style="solid">
            <fo:table-cell padding="3mm">
                <fo:block>
                    <xsl:for-each select="s:Položky/s:Položka">
                        <fo:block text-align-last="justify">
                            <fo:basic-link internal-destination="{generate-id(.)}">
                                <xsl:value-of select="s:IdentifikačníČíslo"/>
                            </fo:basic-link>
                        </fo:block>
                    </xsl:for-each>
                    <fo:basic-link internal-destination="{generate-id(.)}">
                        <fo:page-number-citation ref-id="{generate-id(.)}"/>
                    </fo:basic-link>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="3mm">
                <fo:block>
                    <xsl:value-of select="s:IdentifikačníČíslo"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="3mm">
                <fo:block>
                    <xsl:value-of select="s:Popis"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="3mm">
                <fo:block>
                    <xsl:value-of select="s:CenaZaKus"/>
                    <xsl:value-of select="s:CenaZaKus/@měna"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="3mm">
                <fo:block>
                    <xsl:value-of select="s:Mnozstvi"/>
                    <xsl:value-of select="s:Mnozstvi/@jednotky"/>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>

</xsl:stylesheet>
