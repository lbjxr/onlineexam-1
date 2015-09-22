package exam.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import exam.model.ExamStatus;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import exam.dao.ExamDao;
import exam.dao.base.BaseDaoImpl;
import exam.model.Exam;

@Repository("examDao")
public class ExamDaoImpl extends BaseDaoImpl<Exam> implements ExamDao {
	
	private static String sql = "select * from exam";
	private static String countSql = "select count(id) from exam";
	private static RowMapper<Exam> rowMapper;
	
	static {
		rowMapper = new RowMapper<Exam>() {
			public Exam mapRow(ResultSet rs, int rowNum) throws SQLException {
				Exam exam = new Exam();
				exam.setId(rs.getInt("id"));
				exam.setTitle(rs.getString("title"));
				exam.setStatus(ExamStatus.valueOf(rs.getString("status")));
				exam.setEndTime(rs.getTimestamp("endtime"));
				exam.setJudgePoints(rs.getInt("judgepoints"));
				exam.setLimit(rs.getInt("limit"));
				exam.setMultiPoints(rs.getInt("multipoints"));
				exam.setPoints(rs.getInt("points"));
				exam.setSinglePoints(rs.getInt("singlepoints"));
				return exam;
			}
		};
	}
	
	@Override
	public List<Exam> find(Exam entity) {
		String sql = ExamDaoImpl.sql;
		if (entity != null) {
			StringBuilder where = new StringBuilder(" where 1 = 1 ");
			if (entity.getId() > 0) {
				where.append(" and id = ").append(entity.getId());
			}
			sql += where.toString();
		}
		return jdbcTemplate.query(sql, rowMapper);
	}
	
	public String getCountSql() {
		return countSql;
	}

	public String getSql() {
		return sql;
	}

	public RowMapper<Exam> getRowMapper() {
		return rowMapper;
	}
	
}
