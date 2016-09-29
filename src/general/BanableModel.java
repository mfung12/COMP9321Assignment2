package general;

import ban.Ban;
import ban.Banable;

public class BanableModel extends Model implements Banable {
	private Ban ban = null;
	
	public BanableModel() {
	}
	
	@Override
	public boolean isBanned() {
		return this.ban != null;
	}
	
	@Override
	public String getBannedReason() {
		return this.ban.getReason();
	}

	@Override
	public void findBan(int id) {
		// TODO
	}

	@Override
	public void ban() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void unban() {
		// TODO Auto-generated method stub
	}
}
