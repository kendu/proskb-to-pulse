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
<xsl:text>"Date","Title","Account","Company","Description","Category","Memo","Payment","Deposit"&#xD;&#xA;</xsl:text>
<xsl:for-each select="camt:Ntry">
	<xsl:text>"</xsl:text>

	<!-- date -->
	<xsl:value-of select="camt:ValDt/camt:Dt"/>
	<xsl:text>","</xsl:text>

	<!-- title -->
	<xsl:if test="camt:NtryDtls/camt:TxDtls/camt:RmtInf/camt:Ustrd != ''">
		<xsl:value-of select="normalize-space(camt:NtryDtls/camt:TxDtls/camt:RmtInf/camt:Ustrd)"/>
	</xsl:if>
	<xsl:if test="camt:NtryDtls/camt:TxDtls/camt:RmtInf/camt:Strd/camt:AddtlRmtInf != ''">
	<xsl:value-of select="normalize-space(camt:NtryDtls/camt:TxDtls/camt:RmtInf/camt:Strd/camt:AddtlRmtInf)"/>
	</xsl:if>
	<xsl:text>","</xsl:text>

	<!-- account -->
	<xsl:value-of select="/camt:Document/camt:BkToCstmrStmt/camt:Stmt/camt:Acct/camt:Id/camt:IBAN"/>
	<xsl:text>","</xsl:text>

	<!-- company -->
	<xsl:value-of select="camt:NtryDtls/camt:TxDtls/camt:RltdPties/camt:Cdtr/camt:Nm"/>
	<xsl:text>","</xsl:text>

	<!-- description -->
	<!-- *missing* -->

	<xsl:text>","</xsl:text>

	<!-- category -->
	<!-- *missing* -->

	<xsl:text>","</xsl:text>

	<!-- memo -->
	<!-- *missing* -->

	<xsl:text>","</xsl:text>

	<!-- payment & deposit -->
	<xsl:if test="camt:CdtDbtInd = 'DBIT'"><xsl:value-of select="camt:Amt"/></xsl:if>
	<xsl:text>","</xsl:text>
	<xsl:if test="camt:CdtDbtInd = 'CRDT'"><xsl:value-of select="camt:Amt"/></xsl:if>
	<xsl:text>"&#xD;&#xA;</xsl:text>
</xsl:for-each>
</xsl:template>


<xsl:template match="/"><xsl:apply-templates select="/camt:Document/camt:BkToCstmrStmt/camt:GrpHdr|/camt:Document/camt:BkToCstmrStmt/camt:Stmt"/></xsl:template>

</xsl:stylesheet>


