<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">

    <sch:title>Validace faktury</sch:title>
    <sch:ns uri="http://www.horolezci.cz/" prefix="o"/>
    <sch:ns uri="http://www.w3.org/2001/XMLSchema" prefix="xs"/>

    <sch:pattern>
        <sch:title>validace jedné měny</sch:title>
        <sch:rule context="o:Položka">
            <sch:assert
                test="count(../o:Položka/o:CenaZaKus[@měna = current()/o:CenaZaKus/@měna]) = count(../o:Položka/o:CenaZaKus[@měna])">V objednávce musí být vždy jen jedna měna</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:title>Minimální množství objednávky</sch:title>
        <sch:rule context="o:Položky">        
            <sch:assert test="if(o:Položka/o:Mnozstvi/@jednotky='Kg') then(min(//o:Položka/o:Mnozstvi[@jednotky='Kg'])&gt;= 0.5) else(true())">Minimální výše množství je 0.5 Kg</sch:assert>
            <sch:assert test="if(o:Položka/o:Mnozstvi/@jednotky='g') then(min(//o:Položka/o:Mnozstvi[@jednotky='g'])&gt;= 500) else(true())">Minimální výše množství je 500 g</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:title>Minimální cena v jakékoliv měně</sch:title>
        <sch:rule context="o:Položka">
            <sch:assert test="min(../o:Položka/o:CenaZaKus) &gt; 0">Minimální jednotková cena musí být větší než 0</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:title>Kontrola datumů dodání</sch:title>
        <sch:rule context="o:Položky">
            <sch:assert test="if(../o:metadata/o:DatumDodání &gt;= ../o:metadata/o:DatumObjednání)then (true())else(false())">Datum dodání musí být větší nebo roven datu objednání</sch:assert>
        </sch:rule>
    </sch:pattern>
    
</sch:schema>
