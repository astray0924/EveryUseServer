$('.thumbnails').click(function(event) {
	var btn = $(event.target);
	var btn_type = "";

	// identify the type of the clicked button
	if (btn.hasClass('wow')) {
		btn_type = 'wow';
	} else if (btn.hasClass('metoo')) {
		btn_type = 'metoo';
	} else {
		// undefined behavior
		console.log("undefined comment button pressed.");
	}

	// whether the button is pressed or not
	var button_pressed = !btn.hasClass('active');
	// 버튼 state는 눌린 다음에 변경되므로 반대로 인식해야 함
	var article = btn.parents('.thumbnail');

	// 코멘트 숫자를 담고 있는 엘리먼트들. 코멘트 숫자 변경될 때 내부 숫자를 변경할 필요 있음
	var wows_count_container = article.find('.wows-count');
	var metoos_count_container = article.find('.metoos-count');

	// comment를 추가/삭제할 때 필요한 정보들을 UseCase <div>에서 추출
	var use_case_id = article.attr('data-usecase-id');
	var user_id = article.attr('data-user-id');
	var user_wow_id = article.attr('data-user-wow-id');
	var user_metoo_id = article.attr('data-user-metoo-id');

	// 서버에 comment 제출
	if (use_case_id && user_id) {
		var base_url = "http://localhost:3000/";

		// 눌린 버튼 state에 따라 comment를 추가/삭제
		if (button_pressed) {//추가

			if (btn_type == 'wow') {
				url = base_url + 'wow.json';
			} else if (btn_type == 'metoo') {
				url = base_url + 'metoo.json';
			}

			$.ajax({
				'type' : 'post',
				'url' : url,
				'dataType' : 'json',
				'data' : {
					'comment[user_id]' : user_id,
					'comment[use_case_id]' : use_case_id
				},
				'statusCode' : {
					'422' : function() {
						alert('error commenting the article!');
					}
				}
			}).done(function(data) {
				var comment_id = data.id;

				// UseCase <div>의 속성을 업데이트 해야함
				if (btn_type == 'wow') {
					article.attr('data-user-wow-id', parseInt(comment_id));
				} else if ( btn_type = 'metoo') {
					article.attr('data-user-metoo-id', parseInt(comment_id));
				}
				
				// 여기서는 comment의 갯수 업데이트
				// data.count
			});

		} else {// 삭제

			if (btn_type == 'wow') {
				url = base_url + 'wow/' + user_wow_id + '.json';
			} else if (btn_type == 'metoo') {
				url = base_url + 'metoo/' + user_metoo_id + '.json';
			}

			$.ajax({
				'url' : url,
				'type' : 'delete',
				'success' : function(data) {
					// UseCase <div>의 속성을 업데이트 해야함
					if (btn_type == 'wow') {
						article.attr('data-user-wow-id', 0);
					} else if ( btn_type = 'metoo') {
						article.attr('data-user-metoo-id', 0);
					}
				}
			});
		}
	}
});
