class StarRating extends React.Component{
  componentDidMount(){
    this.starListener();
  }

  render (){
    return(
      <div>
        <div className="row" style={{marginBottom:'0'}}>
          <div className="col s12 start-container" style={{overflowX:'hidden'}}>
            <label>Tour Rating:</label><br/>
              {[...Array(this.props.numberOfStars)].map((_,i) =>
                <p key={"star-"+i} className="star-rating"><span className="star material-icons">star_rate</span></p>
              )}
            <input type="hidden" name={this.props.formName} className="validate"/>
          </div>
        </div>
      </div>
    );
  }

  starListener () {
    $('.star').on('click',function(e){
      $('.star').removeClass('star-selected');
      var currentIndex = $('.star').index(this);
      for(var i = 0;i <= currentIndex;i++){
        var star = $('.star').eq(i);
        star.addClass('star-selected');
      }
      //Set the Hidden input
      $(this).parent().parent().find('input').val(currentIndex+1);
    });
    $('.star').mouseenter(function(){
      $('.star').removeClass('star-hover');
      var currentIndex = $('.star').index(this);
      for(var i = 0;i <= currentIndex;i++){
        var star = $('.star').eq(i);
        star.addClass('star-hover');
      }
    }).mouseleave(function(){
      $('.star').removeClass('star-hover');
    });
    //Click first star
    $('.star').eq(0).trigger('click');
  }
}
StarRating.displayName = "Star Rating";
StarRating.propTypes = {
  formName: React.PropTypes.string.isRequired,
  numberOfStars: React.PropTypes.number.isRequired
};
