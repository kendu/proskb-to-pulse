<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:camt="urn:iso:std:iso:20022:tech:xsd:camt.053.001.02">
<xsl:output method="text" encoding="UTF-8"/>

<xsl:strip-space elements="*" />

<xsl:template match="/camt:Document/camt:BkToCstmrStmt/camt:GrpHdr">
  <xsl:if test="camt:MsgPgntn/camt:PgNb != 1 or camt:MsgPgntn/camt:LastPgInd != 'true'">
    <xsl:message terminate="yes">
      <xsl:text>Incomplete message (not first page or subsequent pages exist)</xsl:text>
    </xsl:message>
  </xsl:if>
</xsl:template>

<xsl:template match="/camt:Document/camt:BkToCstmrStmt/camt:Stmt">
<xsl:text>"Date","Title","Company","Payment","Deposit"&#xD;&#xA;</xsl:text>
<xsl:for-each select="camt:Ntry">
	<xsl:text>"</xsl:text><xsl:value-of select="camt:ValDt/camt:Dt"/><xsl:text>",</xsl:text>

	<xsl:if test="normalize-space(camt:NtryDtls/camt:TxDtls/camt:RmtInf/camt:Strd/camt:CdtrRefInf/camt:Ref) != ''">
		<xsl:text>"</xsl:text><xsl:value-of select="normalize-space(camt:NtryDtls/camt:TxDtls/camt:RmtInf/camt:Strd/camt:CdtrRefInf/camt:Ref)"/><xsl:text>",</xsl:text>
	</xsl:if>
	<xsl:if test="normalize-space(camt:NtryDtls/camt:TxDtls/camt:RmtInf/camt:Strd/camt:CdtrRefInf/camt:Ref) = ''">
		<xsl:text>"</xsl:text><xsl:value-of select="normalize-space(camt:NtryDtls/camt:TxDtls/camt:RmtInf/camt:Ustrd)"/><xsl:text>",</xsl:text>
	</xsl:if>

	<xsl:if test="camt:CdtDbtInd = 'DBIT'">
		<xsl:text>"</xsl:text><xsl:value-of select="camt:NtryDtls/camt:TxDtls/camt:RltdPties/camt:Cdtr/camt:Nm"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:value-of select="camt:Amt"/><xsl:text>",</xsl:text>
		<xsl:text>""</xsl:text>
	</xsl:if>
	<xsl:if test="camt:CdtDbtInd = 'CRDT'">
		<xsl:text>"</xsl:text><xsl:value-of select="camt:NtryDtls/camt:TxDtls/camt:RltdPties/camt:Dbtr/camt:Nm"/><xsl:text>",</xsl:text>
		<xsl:text>"",</xsl:text>
		<xsl:text>"</xsl:text><xsl:value-of select="camt:Amt"/><xsl:text>"</xsl:text>
	</xsl:if>

	<xsl:text>&#xD;&#xA;</xsl:text>
</xsl:for-each>
</xsl:template>


<xsl:template match="/"><xsl:apply-templates select="/camt:Document/camt:BkToCstmrStmt/camt:GrpHdr|/camt:Document/camt:BkToCstmrStmt/camt:Stmt"/></xsl:template>

</xsl:stylesheet>


