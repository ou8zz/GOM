package com.sqe.gom.security;

import java.util.Collection;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import com.sqe.gom.model.GomUser;

/**
 * @description Implementing your own UserService is necessary if
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Mar 17, 2013  11:47:03 PM
 * @version 3.0
 */
public class GomUserDetails implements UserDetails {
	private static final long serialVersionUID = -5226602131176862620L;
	private GomUser user;

	private Collection<GrantedAuthority> roles;
	
	public GomUserDetails(GomUser user, Collection<GrantedAuthority> roles) {
		this.user = user;
		this.roles = roles;
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return roles;
	}

	@Override
	public String getPassword() {
		return user.getPwd();
	}

	@Override
	public String getUsername() {
		return user.getEname();
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return !user.isLock();
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return user.isActive();
	}
	
	public void setUser(GomUser user) {
		this.user = user;
	}

	public GomUser getUser() {
		return user;
	}
	
	@Override
	public boolean equals(Object object) {
		if (object instanceof GomUserDetails) {
			if (this.user.getId().equals(((GomUserDetails) object).user.getId()))
				return true;
		}
		return false;
	}

	@Override
	public int hashCode() {
		return this.user.getId().hashCode();
	}
}
