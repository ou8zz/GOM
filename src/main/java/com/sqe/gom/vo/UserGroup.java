/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.vo;

import java.io.Serializable;
import java.util.Locale;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.ApprovalStatus;
import com.sqe.gom.constant.EmployeeCate;
import com.sqe.gom.constant.GenderType;

/**
 * @description write some comment please.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 6, 2011, 3:58:27 PM
 * @version 3.0
 */
public class UserGroup implements Serializable {
	private static final long serialVersionUID = -6069777537830288751L;

	@Expose
	private Integer id;
	@Expose
	private EmployeeCate type;
	@Expose
	private String jobNo;
	@Expose
	private String ename;
	@Expose
	private String cname;
	@Expose
	private GenderType gender; 
	@Expose
	private String cell;
	@Expose
	private String email;
	@Expose
	private String emailPwd;
	@Expose
	private String position;
	@Expose
	private String department;
	@Expose
	private String role;
	@Expose
	private Integer dptId;
	@Expose
	private Integer pstId;
	@Expose
	private String cposition;
	@Expose
	private String cdepartment;
	@Expose
	private String crole;
	@Expose
	private Integer roleId;
	@Expose
	private ApprovalStatus state;
	@Expose
	private String portrait;
	@Expose
	private String comment;
	@Expose
	private Locale locale;
	@Expose
	private int onlineUsers;
	
	private String pwd;
	
	public UserGroup() {}
	
	//查询用户部门，职务等基本信息
	public UserGroup(Integer id, String jobNo, String ename, String cname, GenderType gender, EmployeeCate type, Integer dptId, String department, Integer pstId, String position) {
		this.id = id;
		this.jobNo = jobNo;
		this.ename = ename;
		this.cname = cname;
		this.gender = gender;
		this.type =  type;
		this.dptId = dptId;
		this.department = department;
		this.pstId = pstId;
		this.position = position;
	}
	
	//查询用户部门，职务，角色基本信息
	public UserGroup(Integer id, String jobNo, String ename, String cname, GenderType gender, EmployeeCate type, Integer dptId, String department, Integer pstId, String position, Integer roleId, String role) {
		this.id = id;
		this.jobNo = jobNo;
		this.ename = ename;
		this.cname = cname;
		this.gender = gender;
		this.type =  type;
		this.dptId = dptId;
		this.department = department;
		this.pstId = pstId;
		this.position = position;
		this.roleId = roleId;
		this.role = role;
	}
	
	//查询请假代理人
	public UserGroup(Integer id, String jobNo, String ename, String cname, String email, String cell, String egroup, String cgroup) {
		this.id = id;
		this.jobNo = jobNo;
		this.ename = ename;
		this.cname = cname;
		this.email = email;
		this.cell = cell;
		this.position = egroup;
		this.cposition = cgroup;
		this.department = egroup;
		this.cdepartment = cgroup;
	}
	
	public UserGroup(Integer id, String ename, String cname, String email) {
		this.id = id;
		this.ename = ename;
		this.cname = cname;
		this.email = email;
	}

	public UserGroup(Integer id, String jobNo, String ename, String cname,String email, String cell, Integer dptId, String cdepartment, Integer pstId, String cposition) {
		this.id = id;
		this.jobNo = jobNo;
		this.ename = ename;
		this.cname = cname;
		this.email = email;
		this.dptId = dptId;
		this.cdepartment = cdepartment;
		this.pstId = pstId;
		this.cposition = cposition;
	}
			
	public UserGroup(Integer id, String jobNo, String ename, String cname, String email, String cell, String position, String cposition, String department, String cdepartment) {
		this.id = id;
		this.jobNo = jobNo;
		this.ename = ename;
		this.cname = cname;
		this.email = email;
		this.cell = cell;
		this.position = position;
		this.cposition = cposition;
		this.department = department;
		this.cdepartment = cdepartment;
	}
	
	public UserGroup(Integer id, String jobNo, String ename, String cname, String email, String cell, Integer pstId, String position, String cposition, Integer dptId, String department, String cdepartment) {
		this.id = id;
		this.jobNo = jobNo;
		this.ename = ename;
		this.cname = cname;
		this.email = email;
		this.cell = cell;
		this.pstId = pstId;
		this.position = position;
		this.cposition = cposition;
		this.dptId = dptId;
		this.department = department;
		this.cdepartment = cdepartment;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public EmployeeCate getType() {
		return type;
	}

	public void setType(EmployeeCate type) {
		this.type = type;
	}

	public String getJobNo() {
		return jobNo;
	}

	public void setJobNo(String jobNo) {
		this.jobNo = jobNo;
	}

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public GenderType getGender() {
		return gender;
	}

	public void setGender(GenderType gender) {
		this.gender = gender;
	}

	public String getCell() {
		return cell;
	}

	public void setCell(String cell) {
		this.cell = cell;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmailPwd() {
		return emailPwd;
	}

	public void setEmailPwd(String emailPwd) {
		this.emailPwd = emailPwd;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Integer getDptId() {
		return dptId;
	}

	public void setDptId(Integer dptId) {
		this.dptId = dptId;
	}

	public Integer getPstId() {
		return pstId;
	}

	public void setPstId(Integer pstId) {
		this.pstId = pstId;
	}

	public String getCposition() {
		return cposition;
	}

	public void setCposition(String cposition) {
		this.cposition = cposition;
	}

	public String getCdepartment() {
		return cdepartment;
	}

	public void setCdepartment(String cdepartment) {
		this.cdepartment = cdepartment;
	}

	public String getCrole() {
		return crole;
	}

	public void setCrole(String crole) {
		this.crole = crole;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public ApprovalStatus getState() {
		return state;
	}

	public void setState(ApprovalStatus state) {
		this.state = state;
	}

	public String getPortrait() {
		return portrait;
	}

	public void setPortrait(String portrait) {
		this.portrait = portrait;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Locale getLocale() {
		return locale;
	}

	public void setLocale(Locale locale) {
		this.locale = locale;
	}

	public int getOnlineUsers() {
		return onlineUsers;
	}

	public void setOnlineUsers(int onlineUsers) {
		this.onlineUsers = onlineUsers;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getEname()).append(getJobNo()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof UserGroup != true)
			return false;
		UserGroup other = (UserGroup) obj;
		return new EqualsBuilder().append(getJobNo(), other.getJobNo()).append(getEname(), other.getEname()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.jobNo);
		sb.append(",").append(this.ename);
		sb.append(",").append(this.cname);
		sb.append(",").append(this.cell);
		sb.append(",").append(this.email);
		sb.append(",").append(this.emailPwd);
		sb.append(",").append(this.position);
		sb.append("}");
		return sb.toString();
	}
}
