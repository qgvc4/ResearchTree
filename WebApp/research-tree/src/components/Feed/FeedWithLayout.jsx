import React, { Component } from 'react'
import {Redirect} from 'react-router-dom'
import {connect} from 'react-redux'

import { Layout } from 'antd';

import Navbar from '../Navbar';
import Feed from './Feed';
import '../../style/Feed/postFeed.css';

const {
    Content, Sider, Header,
  } = Layout;

class FeedWithLayout extends Component {
    render() {
        return (
            <div>
                {
                    this.props.user.token ? 
                    renderFeed(): 
                    <Redirect to='/Login' />
                }
            </div>
        )
    }
}

function renderFeed() {
    return(
        //try layout
        <div>
            <Layout>
            <Header style={{background:'#c1e791', position: 'fixed', zIndex: 10, width: '100%' }}>
            
            <h1 style={{color:'white', float:'left'}}>ResearchTree</h1>
            </Header>
                <Layout>
                    <Sider >
                        <Navbar pageNum={['1']} />
                    </Sider>
                    <Content style={{marginTop: '6%'}}>
                        <Feed />
                    </Content>
                </Layout>
            </Layout>
        </div>
    );
}

const mapStateToProps = state => ({
    user: state.user.user
})

export default connect(mapStateToProps, {})(FeedWithLayout);