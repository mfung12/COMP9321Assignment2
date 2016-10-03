package search;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import org.xml.sax.SAXException;

import cs9321ass2.*;
import publication.*;
import user.*;
@WebServlet("/search")
public class SearchController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	
	public SearchController()
	{
		super();
	}
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String action = request.getParameter("action");
		String nextPage = "";
		if(action.equals("mainSearch"))
		{
			ResultsBean rsts = (ResultsBean) request.getSession().getAttribute("result");
			List<publication.Publication> mainSearchResults = new LinkedList<publication.Publication>();
			if(!(request.getParameter("input1").equals("")))
			{
				mainSearchResults.addAll(new Publication().searchByKey("title", request.getParameter("input1")/*, false*/));
				mainSearchResults.addAll(new Publication().searchByKey("author", request.getParameter("input1")/*, false*/));
				mainSearchResults.addAll(new Publication().searchByKey("year", request.getParameter("input1")/*, false*/));
				mainSearchResults.addAll(new Publication().searchByKey("publisher", request.getParameter("input1")/*, false*/));
				mainSearchResults.addAll(new Publication().searchByKey("volume", request.getParameter("input1")/*, false*/));
			}
			if(mainSearchResults.size() == 0) request.setAttribute("isEmpty", true);
			else
			{
				request.setAttribute("isEmpty", false);
				rsts.setResults(mainSearchResults);
			}
			nextPage = "results.jsp";
		}
		else if(action.equals("specSearch"))
		{
			ResultsBean rsts = (ResultsBean) request.getSession().getAttribute("result");
			List<Publication> results = new LinkedList<Publication>();
			if(!(request.getParameter("year").equals("")))
				results.addAll(new Publication().searchByKey("year", request.getParameter("year")/*, false*/));
			if(!(request.getParameter("address").equals("")))
				results.addAll(new Publication().searchByKey("address", request.getParameter("address")/*, false*/));
			if(!(request.getParameter("author").equals("")))
				results.addAll(new Publication().searchByKey("author", request.getParameter("author")/*, false*/));
			if(!(request.getParameter("publisher").equals("")))
				results.addAll(new Publication().searchByKey("publisher", request.getParameter("publisher")/*, false*/));
			if(!(request.getParameter("isbn").equals("")))
				results.addAll(new Publication().searchByKey("isbn", request.getParameter("isbn")/*, false*/));
			if(results.size() == 0) request.setAttribute("isEmpty", true);
			else
			{
				request.setAttribute("isEmpty", false);
				rsts.setResults(results);
			}
			nextPage = "results.jsp";
		}
		else if(action.equals("shopCart")) 
		{ //not involving db
			ShopCartBean scb = (ShopCartBean) request.getSession().getAttribute("shopcart");
			if(scb.getPublications().size() == 0) request.setAttribute("isEmpty", true);
			else request.setAttribute("isEmpty", false);
			nextPage = "shopCart.jsp";
		}
		else if(action.equals("addtocartFrDetail"))
		{
			ShopCartBean scb = (ShopCartBean) request.getSession().getAttribute("shopcart");
			DetailBean detailed = (DetailBean) request.getSession().getAttribute("detail");
			List<Publication> inCart = scb.getPublications();
			inCart.add(detailed.getFullDetailed().get(0));
			scb.setPublications(inCart);
			nextPage="shopCart.jsp";
		}
		else if(action.equals("addtocartFrSearchResult"))
		{
			ShopCartBean scb = (ShopCartBean) request.getSession().getAttribute("shopcart");
			ResultsBean rsts = (ResultsBean) request.getSession().getAttribute("result");
			if(!(request.getParameter("srchRslts") == null))
			{
				String position = request.getParameter("srchRslts").trim();
				Publication toAdd = rsts.getResults().get(Integer.parseInt(position));
				List<Publication> inCart = scb.getPublications();
				inCart.add(toAdd);
				scb.setPublications(inCart);
				nextPage = "shopCart.jsp";
			}
			else
			{
				request.setAttribute("noneSelected", true);
				nextPage = "results.jsp";
			}
		}
		else if(action.equals("removeFrCart"))
		{
			ShopCartBean scb = (ShopCartBean) request.getSession().getAttribute("shopcart");
			if(!(request.getParameter("inCarts") ==  null))
			{
				int toRemove = Integer.parseInt(request.getParameter("inCarts").trim());
				List<Publication> tempList = scb.getPublications();
				tempList.remove(toRemove);
				scb.setPublications(tempList);
				if(tempList.size() == 0) request.setAttribute("isEmpty", true);
				else request.setAttribute("isEmpty", false);
			}
			else
				request.setAttribute("noneSelected", true);
			nextPage = "shopCart.jsp";
		}
		RequestDispatcher rd = request.getRequestDispatcher("/"+nextPage);
		rd.forward(request, response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}