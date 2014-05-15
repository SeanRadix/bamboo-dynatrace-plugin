package be.sofico.bamboo.plugins.dynatrace;

import java.util.List;

import com.atlassian.bamboo.resultsummary.ResultsSummary;
import com.atlassian.bamboo.ww2.actions.BuildActionSupport;
import com.atlassian.bamboo.ww2.aware.ResultsListAware;

public class ViewTestAutomation extends BuildActionSupport implements ResultsListAware {
	
	private List<? extends ResultsSummary> resultsList;

	@Override
	public List<? extends ResultsSummary> getResultsList() {
		return resultsList;
	}

	@Override
	public void setResultsList(List<? extends ResultsSummary> results) {
		this.resultsList = results;
	}
}
