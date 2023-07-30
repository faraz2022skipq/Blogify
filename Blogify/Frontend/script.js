$(document).ready(() => {
    const commentButton = document.querySelector('.submit-comment-btn');
    const commentForm = document.querySelector('.comment-form');

    commentButton.addEventListener('click', () => {
        commentForm.classList.toggle('hidden');
    });

    const submitCommentButton = document.querySelector('.submit-comment-btn');
    const commentsList = document.querySelector('.comments-list');

    submitCommentButton.addEventListener('click', () => {
        const textarea = commentForm.querySelector('textarea');
        const commentText = textarea.value.trim();

        if (commentText !== '') {
            const newComment = document.createElement('li');
            newComment.textContent = `User: ${commentText}`;
            commentsList.appendChild(newComment);
            textarea.value = '';
        }
    });
})