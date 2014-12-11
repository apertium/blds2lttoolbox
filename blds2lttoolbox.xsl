<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
            version="1.0"
            encoding="UTF-8"
            indent="yes"/>
<!-- doctype-public="-//Apertium//DTD dix V1.0//EN" -->
<!-- doctype-system="https://sourceforge.net/p/apertium/svn/HEAD/tree/trunk/lttoolbox/lttoolbox/dix.dtd" -->

<xsl:param name="r2l"/>

<xsl:key name="pos-lookup" match="pos-pair" use="blds"/>
<xsl:variable name="pos-table" select="document('pos-table.xml')/posdefs"/>

<xsl:template match="posdefs">  
  <!-- for matching the root of pos-table.xml -->
  <xsl:param name="blds-pos"/>
  <xsl:choose>
    <xsl:when test="key('pos-lookup', $blds-pos)">
      <xsl:value-of select="key('pos-lookup', $blds-pos)/apertium"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$blds-pos"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="Dictionary">
  <dictionary>
    <alphabet/>
    <sdefs>
      <sdef n="n" 	c="Noun"/>
      <sdef n="np" 	c="Proper noun"/>
      <sdef n="top"     c="Toponym"/>
      <sdef n="attr"    c="Attributive"/>
      <sdef n="prn" 	c="Pronoun"/>
      <sdef n="ref" 	c="Reflexive pronoun"/>
      <sdef n="res" 	c="Reciprocal pronoun"/>
      <sdef n="det" 	c="Determiner"/>
      <sdef n="pos" 	c="Possessive"/>
      <sdef n="p1" 	c="1st person"/>
      <sdef n="p2" 	c="2nd person"/>
      <sdef n="p3" 	c="3rd person"/>
      <sdef n="nt" 	c="Neuter"/>
      <sdef n="mf" 	c="Masculine / feminine, also utrum in nouns"/>
      <sdef n="f" 	c="Feminine"/>
      <sdef n="m" 	c="Masculine"/>
      <sdef n="un" 	c="No gender"/>
      <sdef n="sp" 	c="Singular / plural"/>
      <sdef n="sg" 	c="Singular"/>
      <sdef n="du" 	c="Dual"/>
      <sdef n="pl" 	c="Plural"/>
      <sdef n="ind" 	c="Indefinite"/>
      <sdef n="def" 	c="Definite"/>
      <sdef n="nom" 	c="Nominative"/>
      <sdef n="acc" 	c="Accusative"/>
      <sdef n="gen" 	c="Genitive"/>
      <sdef n="dem" 	c="Demonstrative"/>
      <sdef n="itg" 	c="Question word / interrogative"/>
      <sdef n="qnt" 	c="Quantifier"/>
      <sdef n="neg" 	c="Negative"/>
      <sdef n="emph" 	c="Emphatic"/>
      <sdef n="vblex" 	c="Verb"/>
      <sdef n="pass" 	c="-st form"/>
      <sdef n="pstv" 	c="-st verb"/>
      <sdef n="inf" 	c="Infinitive"/>
      <sdef n="pres" 	c="Present"/>
      <sdef n="imp" 	c="Imperative"/>
      <sdef n="pret" 	c="Preterite"/>
      <sdef n="pp" 	c="Perfect participle (vblex/adj)"/>
      <sdef n="pprs" 	c="Present participle (adjectival)"/>
      <sdef n="pr" 	c="Preposition"/>
      <sdef n="adv" 	c="Adverb"/>
      <sdef n="ij" 	c="Interjection"/>
      <sdef n="adj" 	c="Adjective"/>
      <sdef n="sint" 	c="Synthetic (of adjectives)"/>
      <sdef n="part" 	c="Participle (infinitive)"/>
      <sdef n="sep" 	c="Seperable verb/particle"/>
      <sdef n="cnjsub" 	c="Subordinating conjunction"/>
      <sdef n="cnjcoo" 	c="Co-ordinating conjunction"/>
      <sdef n="cnjadv" 	c="Adverbial conjunction"/>
      <sdef n="posi" 	c="Positive"/>
      <sdef n="comp" 	c="Comparative"/>
      <sdef n="sup" 	c="Superlative"/>
      <sdef n="num" 	c="Numeral"/>
      <sdef n="ord" 	c="Ordinal"/>
      <sdef n="acr" 	c="Acronym"/>
      <sdef n="unc"     c="Uncountable"/>
      <sdef n="sent" 	c="Sentence end"/>
      <sdef n="cm" 	c="Comma"/>
      <sdef n="apos" 	c="Apostrophe"/>
      <sdef n="clb" 	c="Possible clause boundary"/>
      <sdef n="lpar" 	c="Left parenthesis"/>
      <sdef n="rpar" 	c="Right parenthesis"/>
      <sdef n="TODO" 	c="Unknown part-of-speech"/>
    </sdefs>
    <pardefs/>

    <section id="main" type="standard">
      <xsl:apply-templates/>
    </section>
  </dictionary>
</xsl:template>

<!-- fall-through NestEntry -->
<xsl:template match="DictionaryEntry">
  <xsl:variable name="pos-value">
    <xsl:choose>
      <xsl:when test="HeadwordCtn/PartOfSpeech/@value">
        <xsl:apply-templates select="$pos-table">
          <xsl:with-param name="blds-pos" select="HeadwordCtn/PartOfSpeech/@value"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="HeadwordBlock/PartOfSpeech/@value">
        <xsl:apply-templates select="$pos-table">
          <xsl:with-param name="blds-pos" select="HeadwordBlock/PartOfSpeech/@value"/>
        </xsl:apply-templates>
      </xsl:when>
      <!-- Some not-yet-handled node structure: -->
      <xsl:otherwise>TODO</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test=".//Translation">
      <xsl:apply-templates>
        <xsl:with-param name="pos">
          <xsl:element name="s">
            <xsl:attribute name="n">
              <xsl:copy-of select="$pos-value"/>
            </xsl:attribute>
          </xsl:element>
        </xsl:with-param>
        <xsl:with-param name="headword">
          <xsl:copy-of select="HeadwordCtn/Headword/text()"/>
          <!-- TODO: for-each HeadwordBlock, GrammaticalGender as pos2 -->
        </xsl:with-param>
      </xsl:apply-templates>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<!-- skip these: -->
<xsl:template match="HeadwordCtn"/>
<xsl:template match="CompositionalPhraseCtn"/> <!-- would be nice, but no -->
<xsl:template match="SenseIndicator"/>
<xsl:template match="Definition"/>
<xsl:template match="DefinitionCtn"/>
<xsl:template match="ExampleCtn"/>
<xsl:template match="Note"/>
<xsl:template match="RangeOfApplication"/>
<xsl:template match="See"/>
<xsl:template match="SeeAlso"/>
<xsl:template match="Choice"/>
<xsl:template match="Example"/>
<xsl:template match="Antonym"/>
<xsl:template match="Inflection"/>
<xsl:template match="Display"/>
<xsl:template match="Pronunciation"/>

<xsl:template name="lt_e_helper">
  <xsl:param name="pos"/>
  <xsl:param name="lword"/>
  <xsl:param name="rword"/>
  <e>
    <p>
      <l>
        <xsl:copy-of select="$lword"/>
        <xsl:copy-of select="$pos"/>
      </l>
      <r>
        <xsl:copy-of select="$rword"/>
        <xsl:copy-of select="$pos"/>
      </r>
    </p>
  </e>
</xsl:template>

<xsl:template name="lt_e">
  <xsl:param name="pos"/>
  <xsl:param name="lword"/>
  <xsl:param name="rword"/>
  <xsl:choose>
    <xsl:when test="not($r2l=string('yes'))">
      <xsl:call-template name="lt_e_helper">
        <xsl:with-param name="pos" select="$pos"/>
        <xsl:with-param name="lword" select="$lword"/>
        <xsl:with-param name="rword" select="$rword"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <!-- flip r and l here: -->
      <xsl:call-template name="lt_e_helper">
        <xsl:with-param name="pos" select="$pos"/>
        <xsl:with-param name="lword" select="$rword"/>
        <xsl:with-param name="rword" select="$lword"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- fall-through TranslationBlock and TranslationCtn -->
<xsl:template match="Translation">
  <xsl:param name="pos"/>
  <xsl:param name="headword"/>
  <xsl:call-template name="lt_e">
    <xsl:with-param name="pos" select="$pos"/>
    <xsl:with-param name="lword" select="$headword"/>
    <xsl:with-param name="rword" select="text()"/>
  </xsl:call-template>
</xsl:template>

<!-- fall-through SenseGrp -->
<xsl:template match="Synonym">
  <xsl:param name="pos"/>
  <xsl:param name="headword"/> <!-- ignored (using text() instead) -->
  <xsl:call-template name="lt_e">
    <xsl:with-param name="pos" select="$pos"/>
    <xsl:with-param name="lword" select="text()"/>
    <xsl:with-param name="rword" select="../Translation/text()"/>
  </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
