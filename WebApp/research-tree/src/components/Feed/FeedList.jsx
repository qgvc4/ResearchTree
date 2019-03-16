import React, { Component } from 'react'

import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import {fetchPosts} from '../../actions/FeedAction'
import FeedCard from './FeedCard';

class FeedList extends Component {
    componentWillMount() {
        this.props.fetchPosts(this.props.token);
    }

    render() {
        this.props.feeds.sort(function(feed1,feed2){
            return new Date(feed2.modifyTime) - new Date(feed1.modifyTime);
        });
        console.log(this.props.feeds);
        
        const feedItems = this.props.feeds.map(feed => (
            <div key={feed.id} style={{margin: '2%'}}>
                <FeedCard title={feed.title} description={feed.description} date={feed.modifyTime}/>
            </div>
        ));
        return (
        <div>
            <h1 style={{ color: '#74997a', textAlign: 'center' }}>Feeds</h1>
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