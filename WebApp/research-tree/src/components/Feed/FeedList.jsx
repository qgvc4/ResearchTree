import React, { Component } from 'react'

import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import {fetchPosts} from '../../actions/FeedAction'

class FeedList extends Component {
    componentWillMount() {
        this.props.fetchPosts(this.props.token);
    }
  render() {
      const feedItems = this.props.feeds.map(feed => (
        <div key={feed.id}>
            <h3>{feed.title}</h3>
            <p>{feed.description}</p>
        </div>
      ));
    return (
      <div>
        <h1>Feeds</h1>
        {feedItems}
      </div>
    )
  }
}

FeedList.propTypes = {
    fetchPosts: PropTypes.func.isRequired
}

const mapStateToProps = state => ({
    token: state.user.user.token,
    feeds: state.feed.feeds,
    error: state.feed.error
  })

export default connect(mapStateToProps, { fetchPosts })(FeedList);