<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.semestralkaMS.cz/LS2018"
    xmlns:s="http://www.semestralkaMS.cz/LS2018" exclude-result-prefixes="s" version="2.0">

    <xsl:output method="html" version="5" encoding="UTF-8"/>

    <xsl:template match="/">
        <html lang="cs">
            <head>
                <link rel="stylesheet" href="style.css" type="text/css"/>
                <title>Dodací list</title>
            </head>
            <body>
                <h1>Dodací list</h1>
                <xsl:call-template name="Obsah"/>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="s:Header">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="s:DodaciList">
        <p>Dodací list: <xsl:value-of select="."/></p>
    </xsl:template>

    <xsl:template match="s:CisObj">
        <p>Číslo objednávky: <xsl:value-of select="."/></p>
    </xsl:template>
    
    <xsl:template match="s:DatumObjednání">
        <p>Datum dodání: <xsl:value-of select="."/></p>
    </xsl:template>

    <xsl:template match="s:DatumDodání">
        <p>Datum dodání: <xsl:value-of select="."/></p>
    </xsl:template>

    <xsl:template match="s:ObjZak">
        <p>Objednávka zákazníka: <xsl:value-of select="."/></p>
    </xsl:template>

    <xsl:template match="s:Dodavatel">
        <table>
            <caption>
                <h2>Dodavatel</h2>
            </caption>
            <xsl:apply-templates/>
        </table>
    </xsl:template>

    <xsl:template match="s:Nazev">
        <tr>
            <td>
                <strong>Společnost: </strong>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="s:Mesto">
        <tr>
            <td>
                <strong>Město: </strong>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="s:Ulice">
        <tr>
            <td>
                <strong>Ulice: </strong>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="s:PSC">
        <tr>
            <td>
                <strong>PSČ: </strong>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="s:Zakaznik">
        <table>
            <caption>
                <h2>Zakazník <xsl:value-of select="./@typ"/></h2>
            </caption>
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    
    <xsl:template name="Obsah">
        <h3>Detail položek</h3>
        <xsl:text>&#10;</xsl:text>
        <xsl:for-each select="//Položka">
            <a href="polozka{position()}.html">
                <xsl:value-of select="IdentifikačníČíslo"/> - <xsl:value-of select="Popis"/>
            </a>
            <br/>
        </xsl:for-each>
    </xsl:template>

    

    <xsl:template match="s:Položky">
        <table>
            <caption>
                <h2>Seznam položek</h2>
            </caption>
            <tr>
                <th>Identifikační číslo</th>
                <th>Popis</th>
                <th>Datum výroby</th>
                <th>Datum expirace</th>
                <th>Pečeť</th>
                <th>Šarže</th>
                <th>Jednotková cena</th>
                <th>Množství</th>
                <th>Počet balení</th>
                <th>QR Kód</th>
                <th>TXT</th>
            </tr>
            <xsl:for-each select="//s:dodacíList/s:Položky/s:Položka">
                <tr>
                    <td>
                        <xsl:value-of select="s:IdentifikačníČíslo"/>
                    </td>
                    <td>
                        <xsl:value-of select="s:Popis"/>
                    </td>
                    <td>
                        <xsl:value-of select="s:Barva"/>
                    </td>
                    <td>
                        <xsl:value-of select="s:Materiál"/>
                    </td>
                    <td>
                        <xsl:value-of select="s:Pohlaví"/>
                    </td>
                    <td>
                        <xsl:value-of select="s:Velikost"/>
                    </td>
                    <td><xsl:value-of select="s:CenaZaKus"/>&#160;<xsl:value-of
                        select="s:CenaZaKus/@měna"/></td>
                    <td><xsl:value-of select="s:Mnozstvi"/>&#160;<xsl:value-of
                            select="s:Mnozstvi/@jednotky"/></td>
                    <td>
                        <xsl:value-of select="Značka"/>
                    </td>
                    <td>
                        <xsl:choose>
                            <xsl:when test="FotoURI[not(text())]">Náhled není k dispozici</xsl:when>
                            <xsl:otherwise>
                                <img alt="Foto položky">
                                    <xsl:attribute name="src">
                                        <xsl:text>png/</xsl:text>
                                        <xsl:value-of select="FotoURI"/>
                                    </xsl:attribute>
                                </img>
                            </xsl:otherwise>
                        </xsl:choose>

                    </td>
                    <td>
                        <xsl:value-of select="s:TXT"/>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
        <xsl:for-each select="//s:dodacíList/s:Položky/s:Položka">
            <xsl:result-document href="polozka{position()}.html">
                <html lang="cs">
                    <head>
                        <link rel="stylesheet" href="style.css" type="text/css"/>
                        <title>
                            <xsl:value-of select="s:IdentifikačníČíslo"/>
                        </title>
                    </head>
                    <body>
                        <table>
                            <caption>
                                <h2>Detail položky - <xsl:value-of select="s:IdentifikačníČíslo"/></h2>
                            </caption>
                            <tr>
                                <th>Identifikační číslo</th>
                                <th>Popis</th>
                                <th>Barva</th>
                                <th>Materiál</th>
                                <th>Pohlaví</th>
                                <th>Velikost</th>
                                <th>Cena za jeden kus</th>
                                <th>Množství</th>
                                <th>Značka</th>
                                <th>Obrázek</th>
                                <th>Text</th>
                            </tr>
                            <tr>
                                <td>
                                    <xsl:value-of select="s:IdentifikačníČíslo"/>
                                </td>
                                <td>
                                    <xsl:value-of select="s:Popis"/>
                                </td>
                                <td>
                                    <xsl:value-of select="s:Barva"/>
                                </td>
                                <td>
                                    <xsl:value-of select="s:Materiál"/>
                                </td>
                                <td>
                                    <xsl:value-of select="s:Pohlaví"/>
                                </td>
                                <td>
                                    <xsl:value-of select="s:Velikost"/>
                                </td>
                                <td><xsl:value-of select="s:CenaZaKus"/>&#160;<xsl:value-of
                                    select="s:CenaZaKus/@měna"/></td>
                                <td><xsl:value-of select="s:Mnozstvi"/>&#160;<xsl:value-of
                                        select="s:Mnozstvi/@jednotky"/></td>
                                <td>
                                    <xsl:value-of select="s:Značka"/>
                                </td>
                                <td>
                                    <xsl:choose>
                                        <xsl:when test="s:FotoURI[not(text())]">Obrázek není k
                                            dispozici</xsl:when>
                                        <xsl:otherwise>
                                            <img alt="Foto položky">
                                                <xsl:attribute name="src">
                                                    <xsl:text>png/</xsl:text>
                                                    <xsl:value-of select="s:FotoURI"/>
                                                </xsl:attribute>
                                            </img>
                                        </xsl:otherwise>
                                    </xsl:choose>

                                </td>
                                <td>
                                    <xsl:value-of select="s:TXT"/>
                                </td>
                            </tr>
                        </table>
                        <p id="footer">
                            <a href="html.html">Zpět</a>
                        </p>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
