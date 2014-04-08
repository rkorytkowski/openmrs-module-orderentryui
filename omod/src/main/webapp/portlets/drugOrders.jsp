<%@ include file="/WEB-INF/template/include.jsp" %>

<script type="text/javascript">
	<openmrs:authentication>var userId = "${authenticatedUser.userId}";</openmrs:authentication>

	//initTabs
	$j(document).ready(function() {
		var c = getTabCookie();
		if (c == null) {
			var tabs = document.getElementById("patientTabs").getElementsByTagName("a");
			if (tabs.length && tabs[0].id)
				c = tabs[0].id;
		}
		changeTab(c);
	});
	
	function setTabCookie(tabType) {
		document.cookie = "drugOrdersTab-" + userId + "="+escape(tabType);
	}
	
	function getTabCookie() {
		var cookies = document.cookie.match('drugOrdersTab-' + userId + '=(.*?)(;|$)');
		if (cookies) {
			return unescape(cookies[1]);
		}
		return null;
	}
	
	function changeTab(tabObj) {
		if (!document.getElementById || !document.createTextNode) {return;}
		if (typeof tabObj == "string")
			tabObj = document.getElementById(tabObj);
		
		if (tabObj) {
			var tabs = tabObj.parentNode.parentNode.getElementsByTagName('a');
			for (var i=0; i<tabs.length; i++) {
				if (tabs[i].className.indexOf('current') != -1) {
					manipulateClass('remove', tabs[i], 'current');
				}
				var divId = tabs[i].id.substring(0, tabs[i].id.lastIndexOf("Tab"));
				var divObj = document.getElementById(divId);
				if (divObj) {
					if (tabs[i].id == tabObj.id)
						divObj.style.display = "";
					else
						divObj.style.display = "none";
				}
			}
			addClass(tabObj, 'current');
			
			setTabCookie(tabObj.id);
		}
		return false;
    }
</script>

<div id="portletDrugOrders">

	<div id="drugOrdersPortlet">
			&nbsp;<a
				href="<openmrs:contextPath />/module/orderentryui/drugOrder.form?patientId=${model.patient.patientId}"><openmrs:message
					code="orderentryui.add" /></a>
			<br />
			<br />
			<div>
				<table id="drugOrdersTable">
					<thead>
						<tr>
							<th>Order Type</th>
							<th>Medication</th>
							<th>Dose</th>
							<th>Frequency</th>
							<th>Instructions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${model.orders}" var="order">
				        	<tr>
				        		<td>Drug Order</td>
				        		<td>${order.drug.name}</td>
				        		<td>${order.dose}</td>
				        		<td>${order.frequency}</td>
				        		<td>${order.dosingInstructions}</td>
				        	</tr>
				        </c:forEach>
					</tbody>
				</table>
			</div>
	</div>
	
</div>