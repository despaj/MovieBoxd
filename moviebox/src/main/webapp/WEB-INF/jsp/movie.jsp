<%@ page pageEncoding="UTF-8" %>
<%@ include file="_head.jsp" %>
<main>
  <div class="hero">
    <c:if test="${not empty movie.poster}"><img src="${movie.poster}" alt=""></c:if>
    <div class="info">
      <h1><c:out value="${movie.title}"/> <span class="muted">${movie.year}</span></h1>
      <c:if test="${not empty movie.tagline}"><p class="muted"><em><c:out value="${movie.tagline}"/></em></p></c:if>
      <p class="muted">
        <c:out value="${movie.genres}"/>
        <c:if test="${movie.runtime > 0}"> · ${movie.runtime} min</c:if>
      </p>
      <p style="margin:14px 0"><c:out value="${movie.overview}"/></p>
      <p>
        <span class="stars">★</span>
        <c:choose>
          <c:when test="${not empty avg}"><b>${avg}</b> / 5 from ${count} review(s)</c:when>
          <c:otherwise><span class="muted">No reviews yet. Be the first.</span></c:otherwise>
        </c:choose>
      </p>
    </div>
  </div>

  <div class="form">
    <form method="post" action="/movies/${movie.id}/review">
      <b><c:choose><c:when test="${empty mine}">Rate this film</c:when><c:otherwise>Update your review</c:otherwise></c:choose></b><br>
      <div class="star-input">
        <c:forEach var="i" begin="1" end="5">
          <c:set var="v" value="${6 - i}"/>
          <input type="radio" id="s${v}" name="rating" value="${v}" <c:if test="${mine.rating == v}">checked</c:if>>
          <label for="s${v}" title="${v} stars">★</label>
        </c:forEach>
      </div>
      <textarea name="comment" maxlength="1000" placeholder="Add a comment (optional)"><c:out value="${mine.body}"/></textarea>
      <button class="btn" type="submit">Save review</button>
    </form>
    <c:if test="${not empty mine}">
      <form method="post" action="/reviews/${mine.id}/delete" style="margin-top:8px">
        <button class="btn del" type="submit">Delete my review</button>
      </form>
    </c:if>
  </div>

  <h2>Reviews</h2>
  <div class="reviews">
    <c:forEach var="r" items="${reviews}">
      <div class="review">
        <div>
          <b><c:out value="${r.userName}"/></b>
          <span class="stars">${r.stars}</span>
          <small class="muted">${r.dateLabel}</small>
          <p><c:out value="${r.body}"/></p>
        </div>
      </div>
    </c:forEach>
    <c:if test="${empty reviews}"><p class="muted">No reviews yet.</p></c:if>
  </div>
</main>
</body>
</html>
