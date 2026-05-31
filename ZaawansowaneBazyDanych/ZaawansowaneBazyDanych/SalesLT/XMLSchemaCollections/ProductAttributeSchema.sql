CREATE XML SCHEMA COLLECTION [SalesLT].[ProductAttributeSchema]
    AS N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <xsd:element name="ProductAttributes">
    <xsd:complexType>
      <xsd:complexContent>
        <xsd:restriction base="xsd:anyType">
          <xsd:sequence>
            <xsd:element name="Weight" type="xsd:string" />
            <xsd:element name="Color" type="xsd:string" />
            <xsd:element name="Size" type="xsd:string" />
            <xsd:element name="Style" type="xsd:string" />
            <xsd:element name="Material" type="xsd:string" />
          </xsd:sequence>
        </xsd:restriction>
      </xsd:complexContent>
    </xsd:complexType>
  </xsd:element>
</xsd:schema>';
GO

