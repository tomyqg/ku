package com.kuyun.eam.dao.model;

import com.kuyun.common.dao.model.BaseEntity;
import java.io.Serializable;
import java.math.BigDecimal;

public class EamSensor extends BaseEntity implements Serializable {
    private Integer sensorId;

    private Integer equipmentModelPropertyId;

    /**
     * Modbus RTU 功能码
     *
     * @mbg.generated
     */
    private Integer functionCode;

    /**
     * Modbus RTU 起始地址
     *
     * @mbg.generated
     */
    private Integer address;

    /**
     * Modbus RTU 数据格式
     *
     * @mbg.generated
     */
    private String dataFormat;

    /**
     * Modbus RTU 字节顺序
     *
     * @mbg.generated
     */
    private String bitOrder;

    /**
     * Modbus RTU
     *
     * @mbg.generated
     */
    private Integer period;

    /**
     * Modbus RTU 地址个数
     *
     * @mbg.generated
     */
    private Integer quantity;

    /**
     * Modbus RTU
     *
     * @mbg.generated
     */
    private Integer writeNumber;

    /**
     * 巨控 读写指令
     *
     * @mbg.generated
     */
    private String grmAction;

    /**
     * 巨控 变量名
     *
     * @mbg.generated
     */
    private String grmVariable;

    /**
     * 巨控 写变量值
     *
     * @mbg.generated
     */
    private String grmVariableValue;

    /**
     * 换算结果的高限
     *
     * @mbg.generated
     */
    private BigDecimal osh;

    /**
     * 换算结果的低限
     *
     * @mbg.generated
     */
    private BigDecimal osl;

    /**
     * 换算对象的高限
     *
     * @mbg.generated
     */
    private BigDecimal ish;

    /**
     * 换算对象的低限
     *
     * @mbg.generated
     */
    private BigDecimal isl;

    private static final long serialVersionUID = 1L;

    public Integer getSensorId() {
        return sensorId;
    }

    public void setSensorId(Integer sensorId) {
        this.sensorId = sensorId;
    }

    public Integer getEquipmentModelPropertyId() {
        return equipmentModelPropertyId;
    }

    public void setEquipmentModelPropertyId(Integer equipmentModelPropertyId) {
        this.equipmentModelPropertyId = equipmentModelPropertyId;
    }

    public Integer getFunctionCode() {
        return functionCode;
    }

    public void setFunctionCode(Integer functionCode) {
        this.functionCode = functionCode;
    }

    public Integer getAddress() {
        return address;
    }

    public void setAddress(Integer address) {
        this.address = address;
    }

    public String getDataFormat() {
        return dataFormat;
    }

    public void setDataFormat(String dataFormat) {
        this.dataFormat = dataFormat;
    }

    public String getBitOrder() {
        return bitOrder;
    }

    public void setBitOrder(String bitOrder) {
        this.bitOrder = bitOrder;
    }

    public Integer getPeriod() {
        return period;
    }

    public void setPeriod(Integer period) {
        this.period = period;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Integer getWriteNumber() {
        return writeNumber;
    }

    public void setWriteNumber(Integer writeNumber) {
        this.writeNumber = writeNumber;
    }

    public String getGrmAction() {
        return grmAction;
    }

    public void setGrmAction(String grmAction) {
        this.grmAction = grmAction;
    }

    public String getGrmVariable() {
        return grmVariable;
    }

    public void setGrmVariable(String grmVariable) {
        this.grmVariable = grmVariable;
    }

    public String getGrmVariableValue() {
        return grmVariableValue;
    }

    public void setGrmVariableValue(String grmVariableValue) {
        this.grmVariableValue = grmVariableValue;
    }

    public BigDecimal getOsh() {
        return osh;
    }

    public void setOsh(BigDecimal osh) {
        this.osh = osh;
    }

    public BigDecimal getOsl() {
        return osl;
    }

    public void setOsl(BigDecimal osl) {
        this.osl = osl;
    }

    public BigDecimal getIsh() {
        return ish;
    }

    public void setIsh(BigDecimal ish) {
        this.ish = ish;
    }

    public BigDecimal getIsl() {
        return isl;
    }

    public void setIsl(BigDecimal isl) {
        this.isl = isl;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", sensorId=").append(sensorId);
        sb.append(", equipmentModelPropertyId=").append(equipmentModelPropertyId);
        sb.append(", functionCode=").append(functionCode);
        sb.append(", address=").append(address);
        sb.append(", dataFormat=").append(dataFormat);
        sb.append(", bitOrder=").append(bitOrder);
        sb.append(", period=").append(period);
        sb.append(", quantity=").append(quantity);
        sb.append(", writeNumber=").append(writeNumber);
        sb.append(", grmAction=").append(grmAction);
        sb.append(", grmVariable=").append(grmVariable);
        sb.append(", grmVariableValue=").append(grmVariableValue);
        sb.append(", osh=").append(osh);
        sb.append(", osl=").append(osl);
        sb.append(", ish=").append(ish);
        sb.append(", isl=").append(isl);
        sb.append("]");
        return sb.toString();
    }

    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        EamSensor other = (EamSensor) that;
        return (this.getSensorId() == null ? other.getSensorId() == null : this.getSensorId().equals(other.getSensorId()))
            && (this.getEquipmentModelPropertyId() == null ? other.getEquipmentModelPropertyId() == null : this.getEquipmentModelPropertyId().equals(other.getEquipmentModelPropertyId()))
            && (this.getFunctionCode() == null ? other.getFunctionCode() == null : this.getFunctionCode().equals(other.getFunctionCode()))
            && (this.getAddress() == null ? other.getAddress() == null : this.getAddress().equals(other.getAddress()))
            && (this.getDataFormat() == null ? other.getDataFormat() == null : this.getDataFormat().equals(other.getDataFormat()))
            && (this.getBitOrder() == null ? other.getBitOrder() == null : this.getBitOrder().equals(other.getBitOrder()))
            && (this.getPeriod() == null ? other.getPeriod() == null : this.getPeriod().equals(other.getPeriod()))
            && (this.getQuantity() == null ? other.getQuantity() == null : this.getQuantity().equals(other.getQuantity()))
            && (this.getWriteNumber() == null ? other.getWriteNumber() == null : this.getWriteNumber().equals(other.getWriteNumber()))
            && (this.getGrmAction() == null ? other.getGrmAction() == null : this.getGrmAction().equals(other.getGrmAction()))
            && (this.getGrmVariable() == null ? other.getGrmVariable() == null : this.getGrmVariable().equals(other.getGrmVariable()))
            && (this.getGrmVariableValue() == null ? other.getGrmVariableValue() == null : this.getGrmVariableValue().equals(other.getGrmVariableValue()))
            && (this.getOsh() == null ? other.getOsh() == null : this.getOsh().equals(other.getOsh()))
            && (this.getOsl() == null ? other.getOsl() == null : this.getOsl().equals(other.getOsl()))
            && (this.getIsh() == null ? other.getIsh() == null : this.getIsh().equals(other.getIsh()))
            && (this.getIsl() == null ? other.getIsl() == null : this.getIsl().equals(other.getIsl()))
            && (this.getCreateUserId() == null ? other.getCreateUserId() == null : this.getCreateUserId().equals(other.getCreateUserId()))
            && (this.getCreateTime() == null ? other.getCreateTime() == null : this.getCreateTime().equals(other.getCreateTime()))
            && (this.getUpdateUserId() == null ? other.getUpdateUserId() == null : this.getUpdateUserId().equals(other.getUpdateUserId()))
            && (this.getUpdateTime() == null ? other.getUpdateTime() == null : this.getUpdateTime().equals(other.getUpdateTime()))
            && (this.getDeleteFlag() == null ? other.getDeleteFlag() == null : this.getDeleteFlag().equals(other.getDeleteFlag()))
            && (this.getCompanyId() == null ? other.getCompanyId() == null : this.getCompanyId().equals(other.getCompanyId()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getSensorId() == null) ? 0 : getSensorId().hashCode());
        result = prime * result + ((getEquipmentModelPropertyId() == null) ? 0 : getEquipmentModelPropertyId().hashCode());
        result = prime * result + ((getFunctionCode() == null) ? 0 : getFunctionCode().hashCode());
        result = prime * result + ((getAddress() == null) ? 0 : getAddress().hashCode());
        result = prime * result + ((getDataFormat() == null) ? 0 : getDataFormat().hashCode());
        result = prime * result + ((getBitOrder() == null) ? 0 : getBitOrder().hashCode());
        result = prime * result + ((getPeriod() == null) ? 0 : getPeriod().hashCode());
        result = prime * result + ((getQuantity() == null) ? 0 : getQuantity().hashCode());
        result = prime * result + ((getWriteNumber() == null) ? 0 : getWriteNumber().hashCode());
        result = prime * result + ((getGrmAction() == null) ? 0 : getGrmAction().hashCode());
        result = prime * result + ((getGrmVariable() == null) ? 0 : getGrmVariable().hashCode());
        result = prime * result + ((getGrmVariableValue() == null) ? 0 : getGrmVariableValue().hashCode());
        result = prime * result + ((getOsh() == null) ? 0 : getOsh().hashCode());
        result = prime * result + ((getOsl() == null) ? 0 : getOsl().hashCode());
        result = prime * result + ((getIsh() == null) ? 0 : getIsh().hashCode());
        result = prime * result + ((getIsl() == null) ? 0 : getIsl().hashCode());
        result = prime * result + ((getCreateUserId() == null) ? 0 : getCreateUserId().hashCode());
        result = prime * result + ((getCreateTime() == null) ? 0 : getCreateTime().hashCode());
        result = prime * result + ((getUpdateUserId() == null) ? 0 : getUpdateUserId().hashCode());
        result = prime * result + ((getUpdateTime() == null) ? 0 : getUpdateTime().hashCode());
        result = prime * result + ((getDeleteFlag() == null) ? 0 : getDeleteFlag().hashCode());
        result = prime * result + ((getCompanyId() == null) ? 0 : getCompanyId().hashCode());
        return result;
    }
}