<%@ page pageEncoding="UTF-8" %>
<%@ include file="_head.jsp" %>
<main>
  <h1><c:out value="${user.fname}"/>'s diary</h1>
  <p class="muted">${mine.size()} films rated · average <span class="stars">★</span> ${average}</p>

  <h2>Your reviews</h2>
  <div class="reviews">
    <c:forEach var="r" items="${mine}">
      <div class="review">
        <c:if test="${not empty r.posterUrl}"><a href="/movies/${r.tmdbId}"><img src="${r.posterUrl}" alt=""></a></c:if>
        <div>
          <a href="/movies/${r.tmdbId}"><b><c:out value="${r.movieTitle}"/></b></a>
          <span class="stars">${r.stars}</span>
          <small class="muted">${r.dateLabel}</small>
          <p><c:out value="${r.body}"/></p>
        </div>
      </div>
    </c:forEach>
    <c:if test="${empty mine}"><p class="muted">You haven't rated any films yet. Head to <a href="/home" style="color:#00b894">Films</a> to start.</p></c:if>
  </div>
</main>
</body>
</html>
